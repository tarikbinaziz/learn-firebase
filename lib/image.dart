import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart 'as fstorage;

class ImageStore extends StatefulWidget {
  const ImageStore({super.key});

  @override
  State<ImageStore> createState() => _ImageStoreState();
}

class _ImageStoreState extends State<ImageStore> {

  File? imgFile;
  final picker = ImagePicker();

  fstorage.FirebaseStorage firebaseStorage=fstorage.FirebaseStorage.instance;

  getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        imgFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: imgFile != null
                    ? Image.file(imgFile!.absolute)
                    : Icon(Icons.photo),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("upload"))
          ],
        ),
      ),
    );
  }
}

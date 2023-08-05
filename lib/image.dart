import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as fstorage;

class ImageStore extends StatefulWidget {
  const ImageStore({super.key});

  @override
  State<ImageStore> createState() => _ImageStoreState();
}

class _ImageStoreState extends State<ImageStore> {
  File? imgFile;
  final picker = ImagePicker();
  final dbRef = FirebaseDatabase.instance.ref("images");





  fstorage.FirebaseStorage firebaseStorage = fstorage.FirebaseStorage.instance;

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
            ElevatedButton(
                onPressed: () async{
                  fstorage.Reference ref = fstorage.FirebaseStorage.instance
                      .ref('/allImages/'+'22');
                  fstorage.UploadTask uploadTask =
                      ref.putFile(imgFile!.absolute);
                  await Future.value(uploadTask);
                  var newUrl=await ref.getDownloadURL();

                  dbRef.child("1").set({
                    "imageUrl":newUrl.toString()
                  });
                },
                child: Text("upload"))
          ],
        ),
      ),
    );
  }
}

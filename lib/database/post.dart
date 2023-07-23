import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  var textCon = TextEditingController();

  bool isLoading = false;
  final databaseRef = FirebaseDatabase.instance.ref("post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Db"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: textCon,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "what is your mind", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child("comments").set(
                    {
                      "title":"who r you",
                      "id": textCon.text.toString(),
                    },
                  ).then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("added")));
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                child: isLoading
                    ? Transform.scale(scale: 0.5,
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                    : Text("add"))
          ],
        ),
      ),
    );
  }
}

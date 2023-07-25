import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class UserAuth {
  userSignUp(String email, password, context) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user!.uid.isNotEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
    }
  }

  userSignIn(String email, password, context) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));

  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final dbRef = FirebaseDatabase.instance.ref("messages");
  var mesCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("chat screen"),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Card(
            color: Colors.blue[100],
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: mesCon,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final newDbRef = dbRef.push();
                        newDbRef.set({"text": mesCon.text});
                        mesCon.clear();
                      },
                      child: Icon(Icons.send))
                ],
              ),
            ),
          ),
        ),
        body: FirebaseAnimatedList(
            padding: EdgeInsets.all(10),
            query: dbRef,
            itemBuilder: (context, snapshot, animation, index) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Card(
                  elevation: 10,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      borderSide: BorderSide.none),
                  child: Container(
                    // margin: EdgeInsets.all(6),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.blue,width: 1.5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(snapshot.child("text").value.toString()),
                  ),
                ),
              );
            }));
  }
}

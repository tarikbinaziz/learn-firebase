import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase_flutter/database/post.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({super.key});

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  final auth = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref("post");
  final searchCon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => UserPosts()));
        },
        child: Text("add"),
      ),
      appBar: AppBar(
        title: Text("Your post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchCon,
              decoration: InputDecoration(
                  hintText: "search", border: OutlineInputBorder()),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (_, snapshot, animation, index) {
                    final title=snapshot.child("title").value.toString();
                    if(searchCon.text.isEmpty){
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                      );
                    }else if(title.toLowerCase().contains(searchCon.text.toLowerCase())){
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                      );
                    }
                    return Container();

                  }),
            )
          ],
        ),
      ),
    );
  }
}

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
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {

                    Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list=[];
                    list.clear();
                    list=map.values.toList();

                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index]['title']),
                              subtitle: Text(list[index]['id'].toString()),
                            );
                          });
                    }

                  })),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (_, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child("title").value.toString()),
                  );
                }),
          )
        ],
      ),
    );
  }
}

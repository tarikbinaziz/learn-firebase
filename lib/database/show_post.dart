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
  final searchCon = TextEditingController();
  final updateCon = TextEditingController();

  showMyDialouge(String title, id) {
    updateCon.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update"),
            content: TextField(
              controller: updateCon,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    ref.child(id)
                        .update({"title": updateCon.text.toLowerCase()}).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("post updated"),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text("update")),
            ],
          );
        });
  }

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
              onChanged: (String value) {
                setState(() {});
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (_, snapshot, animation, index) {
                    final title = snapshot.child("title").value.toString();
                    if (searchCon.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (_) {
                              return [
                                PopupMenuItem(
                                  child: ListTile(
                                    onTap: () {
                                      showMyDialouge(
                                          title,
                                          snapshot
                                              .child("id")
                                              .value
                                              .toString());
                                    },
                                    title: Text("edit"),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Text("delete"),
                                    onTap: (){
                                      ref.child(snapshot.child("id").value.toString()).remove();
                                    },
                                  ),
                                ),
                              ];
                            }),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(searchCon.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                      );
                    }
                    return Container();
                  }),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    Map map = snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(list[index]["title"]),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

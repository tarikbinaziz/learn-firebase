import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealTimePractise extends StatefulWidget {
  const RealTimePractise({super.key});

  @override
  State<RealTimePractise> createState() => _RealTimePractiseState();
}

class _RealTimePractiseState extends State<RealTimePractise> {
  final realTimeDbRef = FirebaseDatabase.instance.ref("users");
  String? id;

  final nameCon = TextEditingController();
  final passCon = TextEditingController();
  final updateCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("real time practise"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameCon,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: passCon,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 24,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    final newRealRef = realTimeDbRef.push();
                    newRealRef.set({
                      "name": nameCon.text,
                      "title": passCon.text,
                    }).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("added"),
                        ),
                      ),
                    );
                  },
                  child: Text("send")),
            ),
            Expanded(
                child: FirebaseAnimatedList(
                    query: realTimeDbRef,
                    itemBuilder: (_, snapshot, animation, index) {
                      var dataKey = snapshot.key;
                      return ListTile(
                        title: Text(snapshot.child("name").value.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            updateCon.text=snapshot.child("name").value.toString();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("update"),
                                    content: TextField(controller: updateCon,),
                                    actions: [
                                    TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("cancel")),
                                     TextButton(
                                              onPressed: () {
                                                realTimeDbRef.child(dataKey!).update({
                                                  "name": updateCon.text.toLowerCase()
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text("update"))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.edit),
                        ),
                      );
                    })),
            // Expanded(
            //   child: StreamBuilder(
            //       stream: realTimeDbRef.onValue,
            //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //         Map map = snapshot.data!.snapshot.value as dynamic;
            //         List<dynamic> list = [];
            //         list.clear();
            //         list = map.values.toList();
            //         if (!snapshot.hasData) {
            //           return CircularProgressIndicator();
            //         } else {
            //           return ListView.builder(
            //               itemCount: snapshot.data!.snapshot.children.length,
            //               itemBuilder: (_, index) {
            //                 return ListTile(
            //                   title: Text(list[index]["name"]),
            //                 );
            //               });
            //         }
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}

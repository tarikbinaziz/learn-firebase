import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'email_password/email_pass_signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    /// forground
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        var snacbar = SnackBar(
          content: Text(message.notification!.title.toString()),
          duration: Duration(days: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snacbar);
        print(message.notification!.title);
      }
    });

    /// background
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        var snacbar = SnackBar(
          content: Text(message.notification!.title.toString()),
          duration: Duration(days: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snacbar);
        print(message.notification!.title);
      }
    });

    /// terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        var snacbar = SnackBar(
          content: Text(message.notification!.title.toString()),
          duration: Duration(days: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snacbar);
        print(message.notification!.title);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SigninEmailPass()));
            },
            icon: Icon(Icons.logout)),
      ),
      body: Center(child: Text("welcome Home")),
    );
  }
}

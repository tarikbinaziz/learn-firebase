import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase_flutter/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'email_password/email_pass_signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServicess notificationServices=NotificationServicess();
  @override
  void initState() {
    notificationServices.requestNotificationPermission();
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

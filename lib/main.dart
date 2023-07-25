import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'database/chat screen.dart';
import 'database/show_post.dart';
import 'email_password/email_pass_signin.dart';
import 'email_password/email_pass_signup.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.brown),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {},
            child: ChatScreen())
        //RealTimePractise()
        // ShowPost()

        );
  }
}

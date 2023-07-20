import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.dart';

class EmailPassAuthService {
  emailPassSignup(email, password, context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = credential.user!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", authCredential.uid);

      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBar(content: Text("Weak password"));
      } else if (e.code == 'email-already-in-use') {
        SnackBar(content: Text('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
    }
  }

  emailPassSignin(email, password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("uid", authCredential.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("user not found")));

      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("wrong password")));
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:learn_firebase_flutter/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../phone/phone_auth.dart';
import 'auth service/email_pass_auth_service.dart';
import 'email_pass_forgot.dart';
import 'email_pass_signup.dart';

class SigninEmailPass extends StatefulWidget {
  const SigninEmailPass({super.key});

  @override
  State<SigninEmailPass> createState() => _SigninEmailPassState();
}

class _SigninEmailPassState extends State<SigninEmailPass> {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  EmailPassAuthService emailPassAuthService = EmailPassAuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: passController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ForgotEmailPass()));
                  },
                  child: Text("Forgot password")),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {
                  EmailPassAuthService().emailPassSignin(
                      emailController.text, passController.text, context);
                },
                child: Text("Log in")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have no Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignupEmailPass()));
                    },
                    child: Text("Sign up"))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PhoneAuth()));

                },
                child: Text("Log in with phone")),
          ],
        ),
      ),
    );
  }
}

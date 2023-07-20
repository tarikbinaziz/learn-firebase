import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth service/email_pass_auth_service.dart';

class SignupEmailPass extends StatefulWidget {
  const SignupEmailPass({super.key});

  @override
  State<SignupEmailPass> createState() => _SignupEmailPassState();
}

class _SignupEmailPassState extends State<SignupEmailPass> {
  EmailPassAuthService emailPassAuthService = EmailPassAuthService();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
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
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () async{
                  emailPassAuthService.emailPassSignup(
                      emailController.text, passController.text, context);
                },
                child: Text("Sign up")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have  Account?"),
                TextButton(onPressed: () {}, child: Text("Sign in"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'email_pass_signup.dart';

class ForgotEmailPass extends StatefulWidget {
  const ForgotEmailPass({super.key});

  @override
  State<ForgotEmailPass> createState() => _ForgotEmailPassState();
}

class _ForgotEmailPassState extends State<ForgotEmailPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset password"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
            ),

            SizedBox(
              height: 60,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Reset")),

          ],
        ),
      ),
    );
  }
}

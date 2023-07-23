import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase_flutter/phone/verificationPage.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final auth = FirebaseAuth.instance;
  var phoneCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("phone auth"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: phoneCon,
              keyboardType: TextInputType.phone,

              decoration: InputDecoration(hintText: "phone no"),
            ),
            ElevatedButton(
                onPressed: () {
                  auth.verifyPhoneNumber(
                    timeout: const Duration(seconds: 60),
                    phoneNumber: phoneCon.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      print(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => VerificationSreen(
                                    varificationId: verificationId,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      print(e.toString());
                    },
                  );
                },
                child: Text("submit"))
          ],
        ),
      ),
    );
  }
}

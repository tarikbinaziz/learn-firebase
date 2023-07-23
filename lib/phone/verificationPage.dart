import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase_flutter/home.dart';

class VerificationSreen extends StatefulWidget {
  final String varificationId;

  const VerificationSreen({super.key, required this.varificationId});

  @override
  State<VerificationSreen> createState() => _VerificationSreenState();
}

class _VerificationSreenState extends State<VerificationSreen> {
  final auth = FirebaseAuth.instance;
  var varifyCon = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("varify no"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: varifyCon,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "6 digit no"),
            ),
            ElevatedButton(
                onPressed: () async{
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.varificationId,
                      smsCode: varifyCon.text);

                  try{
                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));

                  }catch(e){
                    print(e.toString());

                  }
                },
                child: Text("verify"))
          ],
        ),
      ),
    );
  }
}

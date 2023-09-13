

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServicess{

  FirebaseMessaging messaging=FirebaseMessaging.instance;

  requestNotificationPermission()async{
    NotificationSettings settings=await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge:  true,
      carPlay:  true,
      provisional: true,
      sound: true,
      criticalAlert: true
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("user granted permission");

    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print("user granted provision permission");

    }else{
      print("user denied permission");
    }

  }

}
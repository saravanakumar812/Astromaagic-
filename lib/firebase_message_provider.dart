import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'NotificationDataModel.dart';
import 'notification.dart';

class NotificationListenerProvider {

  final _firebaseMessaging = FirebaseMessaging.instance.getInitialMessage();

  void getMessage() {

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {

      String title = "";
      String message = "";
      String redirectionId = "";
      String redirectionType = "";

      var data = event.data['data'];

      if(data!=null) {
        var convertedResponse = NotificationDataModel.fromJson(
            json.decode(data));

        if(convertedResponse!=null){

          title  = convertedResponse.title.toString();
          message  = convertedResponse.body.toString();
          // if(convertedResponse.customParam != null) {
          // //  redirectionId = convertedResponse.customParam!.redirectionId.toString();
          //   redirectionType = convertedResponse.customParam!.redirectionType.toString();
          // }

          sendNotification(title: title ?? "",
              body: message ?? "",
              redirectionType: redirectionType ?? "",
            redirectionId: redirectionId ?? "",
          );
        }
      }

      // if(Platform.isAndroid) {
      //   // AppleNotification apple = event.notification!.apple!;
      //   AndroidNotification androidNotification = event.notification!.android!;
      //   print("customParams:${json.encode(event.data)}");
      //
      //   if (notification != null && androidNotification != null) {
      //     ///Show local notification
      //
      //   }
      //
      // }

      // else if(Platform.isIOS){
      //   AppleNotification appleNotification = event.notification!.apple!;
      //   print("customParams:${json.encode(event.data)}");
      //
      //   if (notification != null && appleNotification != null) {
      //     ///Show local notification
      //     sendNotification(title: notification.title!,
      //         body: notification.body,
      //         customParams: event.data);
      //   }
      // }

    });
  }
}





import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessaging(RemoteMessage message) async {
print(" title ${message.notification?.title}");
print(" body ${message.notification?.title}");
print(" Data ${message.data}");
}

// Future<void> handleMessage(RemoteMessage? message) async{
// if(message == null) return;
//
// }
// Future<void> initialMessage(RemoteMessage? message) async{
// if(message == null) return;
//
// }

class FireBaseApi{
  final  firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async{
   await firebaseMessaging.requestPermission();
   final FCMTocaken = await firebaseMessaging.getToken();
   print(" token ${FCMTocaken}");
   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging );
   FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundMessaging );

  }
}
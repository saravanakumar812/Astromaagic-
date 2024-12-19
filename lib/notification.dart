import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import '../routes/app_routes.dart';
import 'Provider/MenuDataProvider.dart';

void sendNotification({
  String? title,
  String? body,
  String? redirectionId,
  String? redirectionType,
}) async {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'hello',
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    linux: initializationSettingsLinux,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload) async {
      await handleNotificationRedirection(redirectionId, redirectionType);
    },
  );

  // Define notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_channel',
    'High Importance Notification',
    description: 'This channel is for important notifications',
    importance: Importance.defaultImportance,
  );

  int notificationId = DateTime.now().millisecondsSinceEpoch.hashCode;

  if (Get.key != null) {
  // Display the notification
  flutterLocalNotificationsPlugin.show(
    notificationId,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        priority: Priority.high,
        playSound: true,
        importance: Importance.high,
        // Use high importance
        visibility: NotificationVisibility.public, // Show heads-up notification
      ),
    ),
  );
}
}

Future<void> handleNotificationRedirection(
  String? redirectionId,
  String? redirectionType,
) async {
  if (redirectionId != null &&
      redirectionType != null &&
      redirectionType.isNotEmpty &&
      redirectionId.isNotEmpty) {

    MenuDataProvider userDataProvider =
        Provider.of<MenuDataProvider>(Get.context!, listen: false);
    // if (Get.key != null) {
    //   // App is already open, navigate to the desired screen
    //   // Get.offAllNamed(AppRoutes.MainWidget.toName);
    //
    //   if (redirectionType == "Lead") {
    //     userDataProvider.setSelectedLeadUUID(redirectionId);
    //     userDataProvider.updateLastScreen("MT");
    //     Get.toNamed(AppRoutes.CustomerDetailsLeadScreen.toName);
    //   }
    // } else {
    //   // App is terminated, navigate to the desired screen when opened
    //   WidgetsBinding.instance?.addPostFrameCallback((_) {
    //     if (redirectionType == "Lead") {
    //       userDataProvider.setSelectedLeadUUID(redirectionId);
    //       userDataProvider.updateLastScreen("MT");
    //       Get.toNamed(AppRoutes.CustomerDetailsLeadScreen.toName);
    //     }
    //   });
    // }


  }
}

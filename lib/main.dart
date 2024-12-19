import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:astromaagic/Components/LocaleString.dart';
import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:astromaagic/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Components/theme.dart';
import 'NotificationDataModel.dart';
import 'Provider/MenuDataProvider.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';
import 'UI/SplashScreen/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'firebase_message_provider.dart';
import 'firebase_options.dart';
import 'notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreference().init();
  //
  // ByteData data = await PlatformAssetBundle()
  //     .load('assets/certificate/autorevog-certificate.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  //await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "Astro");

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  initialize();
  runApp(
    ChangeNotifierProvider<MenuDataProvider>(
      create: (_) => MenuDataProvider(),
      child: MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  String title = "";
  String message = "";
  String redirectionId = "";
  String redirectionType = "";
  var data = event.data['data'];
  print(" message_Handler${data}");
  if (data != null) {
    var convertedResponse = NotificationDataModel.fromJson(json.decode(data));
    print("body${convertedResponse.body}");
    print("title${convertedResponse.title}");
    title = convertedResponse.title.toString();
    message = convertedResponse.body.toString();
    sendNotification(
      title: title ?? "",
      body: message ?? "",
      redirectionType: redirectionType ?? "",
      redirectionId: redirectionId ?? "",
    );

  }
}

void initialize() {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);


  FirebaseMessaging.instance.getInitialMessage().then((event) {
    String title = "";
    String message = "";
    String redirectionId = "";
    String redirectionType = "";
    var data = event?.data['data'];
    print(" message_Handler${data}");
    if (data != null) {
      var convertedResponse = NotificationDataModel.fromJson(json.decode(data));
      print("body${convertedResponse.body}");
      print("title${convertedResponse.title}");
      title = convertedResponse.title.toString();
      message = convertedResponse.body.toString();

      // sendNotification(
      //   title: title ?? "",
      //   body: message ?? "",
      //   redirectionType: redirectionType ?? "",
      //   redirectionId: redirectionId ?? "",
      // );

      MenuDataProvider userDataProvider =
      Provider.of<MenuDataProvider>(Get.context!, listen: false);

      // if (redirectionType == "Lead") {
      //   userDataProvider.setSelectedLeadUUID(redirectionId);
      //   userDataProvider.updateLastScreen("MT");
      //   Get.toNamed(AppRoutes.CustomerDetailsLeadScreen.toName);
      // }
    }
  });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print("fftf");
  //   String title = "";
  //   String message = "";
  //   String redirectionId = "";
  //   String redirectionType = "";
  //   var data = event.data['data'];
  //   print(" message_Handler${data}");
  //   if (data == null) {
  //     var convertedResponse = NotificationDataModel.fromJson(json.decode(data));
  //     print("body${convertedResponse.body}");
  //     print("title${convertedResponse.title}");
  //     title = convertedResponse.title.toString();
  //     message = convertedResponse.body.toString();
  //     sendNotification(
  //       title: title ?? "",
  //       body: message ?? "",
  //       redirectionType: redirectionType ?? "",
  //       redirectionId: redirectionId ?? "",
  //     );
  //   }
  // });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };



  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppTheme.screenBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    NotificationListenerProvider().getMessage();
    return GetMaterialApp(
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'astromaagic',
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context)
            .textTheme
            .apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            )
            .copyWith(
              headline6: const TextStyle(
                color: Color(0xff252525),
                fontWeight: FontWeight.bold,
              ),
              subtitle1: const TextStyle(color: Color(0xffA4A4A4)),
              bodyText1: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      //
      // ThemeData(
      //   textSelectionTheme: const TextSelectionThemeData(
      //       //       selectionHandleColor: Colors.transparent),
      //       // ),
      initialRoute: AppRoutes.root.toName,
      getPages: AppPages.list,
      home: const SplashScreen(),
    );
  }
}

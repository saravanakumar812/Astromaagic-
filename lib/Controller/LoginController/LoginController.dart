import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/BottomNavBarScreen.dart';

class LoginController extends GetxController {
  RxBool isLoading = RxBool(false);

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  late MenuDataProvider userDataProvider;
  RxInt selectedTabIndex = RxInt(0);
  RxBool tamilOnclick = RxBool(false);
  RxBool englishOnclick = RxBool(false);
  RxBool hindiOnclick = RxBool(false);
  var oldPass = true.obs;
  var newPass = true.obs;
  final  firebaseMessaging = FirebaseMessaging.instance;
  late String FCMTocaken;
  final List localEnglish = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  ];
  final List localTamil = [
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
  ];
  final List localKannada = [
    {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')},
  ];
  final List localHindi = [
    {'name': 'हिन्दी', 'locale': Locale('hi', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }
  @override
  void onInit() async {
    super.onInit();
    await firebaseMessaging.requestPermission();
    FCMTocaken = (await firebaseMessaging.getToken())!;
    print(" token ${FCMTocaken}");
  }

  loginCall(context) async {
    if (mobileController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Mobile Number".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (passwordController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      'userMobile':mobileController.text,
      'userPassword':passwordController.text,
    };

    isLoading.value = true;
    var response = await _connect.login(payload);
    isLoading.value = false;

    debugPrint("loginCallResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      AppPreference().updateMobileNumber(mobileController.text);
      AppPreference().updateLang(response.data!.userLanguage ?? "");
      AppPreference().updateCountry(response.data!.userCountry ?? "");
      AppPreference().updateUserName(response.data!.userName ?? "");
      AppPreference().updateLoginUserId(response.data!.userId.toString() ?? "");
      AppPreference().updateToken("Bearer ${response.data!.bearerToken!}");
      fcmTokenCall();
      AppPreference().getLoginUserId == '5'
          ? Get.offAllNamed(AppRoutes.adminServicesList.toName)
          : Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false,
      );
    //  Get.offAllNamed(AppRoutes.register.toName);


    }
    else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }


  fcmTokenCall() async {


    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userMobile':AppPreference().getMobileNumber,
      'fcmToken':FCMTocaken,
    };
print("GetUpdateFcmTokenRequest${payload}");
    isLoading.value = true;
    var response = await _connect.getFcmTokenCall(payload);
    isLoading.value = false;

    debugPrint("GetUpdateFcmToken: ${response.toJson()}");
    // if (!response.error!) {
    //   Fluttertoast.showToast(
    //     msg: response.message!,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //
    //
    //
    //
    //
    //
    //
    // }
    // else {
    //   Fluttertoast.showToast(
    //     msg: response.message!,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    // }
  }

  void forgot() {
    userDataProvider.setIsFromForgotOrRegister("Forgot");
    Get.toNamed(AppRoutes.mobileNumberScreen.toName);

  }
}

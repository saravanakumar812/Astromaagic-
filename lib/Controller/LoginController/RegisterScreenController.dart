import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Api_Config/ApiUrl.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Components/image_pickers.dart';
import '../../ResponseModel/CommonResponse.dart';
import '../../ResponseModel/SignUpResponse.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/BottomNavBarScreen.dart';

class RegisterScreenController extends GetxController {
  RxBool married = RxBool(false);
  RxBool unMarried = RxBool(false);
  RxBool working = RxBool(false);
  RxBool business = RxBool(false);
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController timeOfBirthController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  RxString dateformat = RxString("");
  TextEditingController dateAndTimeController = TextEditingController();
  RxString selectedDate = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  Rx<PickedImage?> itemImage = Rx<PickedImage?>(null);
  RxBool isUploading = RxBool(false);
  RxBool isImageSelected = false.obs;
  RxString imageString = RxString("");
  RxBool isUpdateImageAvailable = false.obs;
  var oldPass = true.obs;
  final  firebaseMessaging = FirebaseMessaging.instance;
  late String FCMTocaken;
  @override
  void onInit() async {
    super.onInit();
    await firebaseMessaging.requestPermission();
    FCMTocaken = (await firebaseMessaging.getToken())!;
    print(" token ${FCMTocaken}");
  }

  loginCall(context) async {
    if (fullNameController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Full Name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (dateOfBirthController.text.length < 10) {
      Fluttertoast.showToast(
        msg: "Please Enter Valid Date Of Birth",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if (areaController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Place Of Area",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (cityController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Place Of City",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (stateController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Your Of City",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (timeOfBirthController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Time Of Birth",
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

    Map<String, String> payload = {
      'userName': fullNameController.text,
      'placeOfBirth': cityController.text,
      "stateOfBirth": stateController.text,
      "cityOfBirth": cityController.text,
      "areaOfBirth": areaController.text,
      'dateOfBirth': dateOfBirthController.text,
      'timeOfBirth': timeOfBirthController.text,
      'userPassword': passwordController.text,
      'maritalStatus': married.value == true ? "Married" : "unMarried",
      'userLanguage': AppPreference().getLanguage,
      'userCountry': AppPreference().getCountry,
      'userMobile': AppPreference().getMobileNumber,
      'isMobileVerified': '1',
      "applicationType": "",
      "employment": working.value == true ? "Working" : "Business",
      "marriageDate": married.value == true ? marriageController.text : "",
      'fcmToken': FCMTocaken
    };
    print({payload});
    isUploading.value = true;

    SignUpResponse response;

    if (itemImage.value == null) {
      response = await _connect.registerUpload(payload,  ApiUrl.add_users);
    } else {
      response = await _connect.imgRegisterCall(
          ApiUrl.add_users, itemImage.value!.file!, payload);
    }

    isUploading.value = false;
   // var response = await _connect.register(payload);
    debugPrint("loginCallResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      AppPreference().updateUserName(fullNameController.text ?? "");
      AppPreference().updateToken("Bearer ${response.token!}");
      AppPreference().updateLoginUserId(response.userId!.toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (route) => false,
      );
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

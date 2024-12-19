import 'package:astromaagic/Routes/app_routes.dart';
import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Api_Config/ApiUrl.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';

class ForgotPasswordController extends GetxController {

  RxBool isLoading = RxBool(false);
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  late MenuDataProvider userDataProvider;
  var oldPass = true.obs;
  var newPass = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
  loginCall(context) async {
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
    if (confirmPasswordController.value.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Confirm - Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
 if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
        msg: "Password Mis - Match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      'userMobile': AppPreference().getMobileNumber,
      'userPassword':passwordController.text,
    };

    isLoading.value = true;
    var response = await _connect.commonUpload(payload,  ApiUrl.forgot);
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

      Get.offAllNamed(AppRoutes.Login.toName);
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

}

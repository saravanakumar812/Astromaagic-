import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/MobileNumberResponse.dart';
import '../../Routes/app_routes.dart';

class mobileNumberScreenController extends GetxController {
  RxBool newPass = RxBool(true);
  RxBool isLoading = RxBool(false);
  TextEditingController mobileController = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  String verificationValues = "";
  MobileNumberResponse mobileNumberResponse = MobileNumberResponse();
  late MenuDataProvider userDataProvider;

  @override
  void onInit() {
    super.onInit();
    userDataProvider =
        Provider.of<MenuDataProvider>(Get.context!, listen: false);
  }

  Future<void> generateOTP() async {
    if (mobileController.value.text.isEmpty ||
        mobileController.value.text.length != 10) {
      mobileController.value.text.isEmpty
          ? Fluttertoast.showToast(
              msg: "Please enter Mobile number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            )
          : Fluttertoast.showToast(
              msg: "Mobile Number must be of 10 digit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.setSettings(
    //     appVerificationDisabledForTesting: true);
    print('generateOTPONPressed');
    String phone = '+91' + mobileController.text.toString();
    isLoading.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          Fluttertoast.showToast(
            msg: "Phone verification failed: ${e.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );

          print('messagingError:${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationValues = verificationId;
          userDataProvider.setVerificationValues(verificationId);
          isLoading.value = false;
          Fluttertoast.showToast(
            msg: "Generate OTP Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );

          AppPreference().updateMobileNumber(mobileController.text.toString());

          // Get.to(OTPScreen());
          Get.toNamed(AppRoutes.otp.toName);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phone);
  }

  Future<void> otpGenerated() async{

    Map<String, dynamic> payload = {
      'userMobile':mobileController.text,

    };

    isLoading.value = true;
    var response = await _connect.mobileNumberCall(payload);
    isLoading.value = false;

    debugPrint("MobileNumberResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      userDataProvider.setOtpNumber(response.otpNumber.toString());
      AppPreference().updateMobileNumber(mobileController.text.toString());
      Get.toNamed(AppRoutes.otp.toName);
  } else{
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
}

Future<void> forgotOtpGenerated() async{
    // if (mobileController.value.text.isEmpty ||
    //     mobileController.value.text.length != 10) {
    //   mobileController.value.text.isEmpty
    //       ? Fluttertoast.showToast(
    //     msg: "Please enter Mobile number",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   )
    //       : Fluttertoast.showToast(
    //     msg: "Mobile Number must be of 10 digit",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }

    Map<String, dynamic> payload = {
      'userMobile':mobileController.text,

    };

    isLoading.value = true;
    var response = await _connect.forgotMobileNumberCall(payload);
    isLoading.value = false;

    debugPrint("MobileNumberResponse: ${response.toJson()}");
    if (!response.error!) {
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );
      userDataProvider.setOtpNumber(response.otpNumber.toString());
      AppPreference().updateMobileNumber(mobileController.text.toString());
      Get.toNamed(AppRoutes.otp.toName);
  } else{
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
}

}

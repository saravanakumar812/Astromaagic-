import 'dart:async';

import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:provider/provider.dart';

import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';

class OTPScreenController extends GetxController {
  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();
  TextEditingController fieldFive = TextEditingController();
  TextEditingController fieldSix = TextEditingController();
  final ApiConnect _connect = Get.put(ApiConnect());
  RxString otp = RxString('');
  RxInt otpTimerSeconds = RxInt(60);
  Timer? _otpTimer;
  RxBool showResendOTP = RxBool(true);
  RxBool isLoading = RxBool(false);
  late MenuDataProvider userDataProvider;
  final _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    startOTPTimer();
    super.onInit();
    userDataProvider =
        Provider.of<MenuDataProvider>(Get.context!, listen: false);
    final splitted =  userDataProvider.getOtpNumber!.split('');
    fieldOne.text = splitted[0].toString();
    fieldTwo.text = splitted[1].toString();
    fieldThree.text = splitted[2].toString();
    fieldFour.text = splitted[3].toString();
    fieldFive.text = splitted[4].toString();
    fieldSix.text = splitted[5].toString();
  }

  void startOTPTimer() {
    _otpTimer?.cancel();
    otpTimerSeconds.value = 60;
    showResendOTP.value = false;
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (otpTimerSeconds.value > 0) {
        //// Decrement the timer value
        otpTimerSeconds.value--;
      } else {
        _otpTimer?.cancel();
        showResendOTP.value = true;
      }
    });
  }

  Future<void> verifyOTP() async {
    print('OnclickVerify1');
    String _otp = fieldOne.text +
        fieldTwo.text +
        fieldThree.text +
        fieldFour.text +
        fieldFive.text +
        fieldSix.text;

    if (_otp.isEmpty || _otp.length != 6) {
      _otp.isEmpty
          ? Fluttertoast.showToast(
              msg: "Please enter OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            )
          : Fluttertoast.showToast(
              msg: "OTP must be of 6 digits",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
      return;
    }

    print("Entered OTP:${_otp}");

    try {
      isLoading.value = true;

      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: userDataProvider.getVerificationValues!,
        smsCode: _otp,
      );

      print('authCredential:$credential');
      var result = await _auth.signInWithCredential(credential);
      isLoading.value = false;

      Fluttertoast.showToast(
        msg: "OTP verified successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("userDataProvider.getIsFromForgotOrRegister${userDataProvider.getIsFromForgotOrRegister!}");
      if(userDataProvider.getIsFromForgotOrRegister == "Forgot"){
        Get.offAllNamed(AppRoutes.forgotPassword.toName);
      }else {
        Get.toNamed(AppRoutes.register.toName);
      }
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        // Handle invalid OTP
        print('Invalid OTP');

        isLoading.value = false;

        Fluttertoast.showToast(
          msg: "Error occurred during OTP verification",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        print(e.toString());
      }
    }
  }
  Future<void> otpVerified() async {
    print('OnclickVerify1');
    String _otp = fieldOne.text +
        fieldTwo.text +
        fieldThree.text +
        fieldFour.text +
        fieldFive.text +
        fieldSix.text;

    if (_otp.isEmpty || _otp.length != 6) {
      _otp.isEmpty
          ? Fluttertoast.showToast(
              msg: "Please enter OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            )
          : Fluttertoast.showToast(
              msg: "OTP must be of 6 digits",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
      return;
    }

    print("Entered OTP:${_otp}");
    Map<String, dynamic> payload = {
      'userMobile':AppPreference().getMobileNumber,
      "otpNumber": userDataProvider.getOtpNumber.toString(),
    };

    isLoading.value = true;
    var response = await _connect.otpVerifyCall(payload);
    isLoading.value = false;
    print("OtpVerifyPayload:$payload");
    debugPrint("OtpResponse: ${response.toJson()}");
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print("userDataProvider.getIsFromForgotOrRegister${userDataProvider.getIsFromForgotOrRegister!}");
      if(userDataProvider.getIsFromForgotOrRegister == "Forgot"){
        Get.offAllNamed(AppRoutes.forgotPassword.toName);
      }else {
        Get.toNamed(AppRoutes.register.toName);
      }
    }
}}

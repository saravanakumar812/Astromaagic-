import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/SplashController/SplashScreenController.dart';
import '../LanguageScreen/LanguageScreen.dart';
import '../LoginUI/LoginScreen.dart';
import '../WelcomeScreenUI/WelcomeScreenOne.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Get.off(() => LoginScreen(), transition: Transition.rightToLeft);
    });
 // Future.delayed(Duration(seconds: 4), () {
 //      Get.off(() => LanguageScreen(), transition: Transition.rightToLeft);
 //    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/splash screen - 1.2.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      )),
    );

  }
}

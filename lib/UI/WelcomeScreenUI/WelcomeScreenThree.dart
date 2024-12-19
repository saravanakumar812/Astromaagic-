import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/WelcomeScreenController/WelcomeScreenThreeController.dart';
import '../LoginUI/MobileNumberScreen.dart';

class WelcomeScreenThree extends GetView<WelcomeScreenThreeController> {
  const WelcomeScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 4), () {
      Get.off(() => MobileNumberScreen(), transition: Transition.rightToLeft);
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Image.asset(
                "assets/images/splashTwo.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
              ),
              Center(
                child: Image.asset(
                  "assets/images/Gemmology.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

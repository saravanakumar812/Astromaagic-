import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/GeneralPredictionsController/SuccessfullyPaidScreenController.dart';

class SuccessfullyPaidScreen extends GetView<SuccessfullyPaidScreenController> {
  const SuccessfullyPaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/backgroundImage.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/success.png",
                  fit: BoxFit.cover,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

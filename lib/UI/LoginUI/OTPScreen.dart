import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/OTPInput.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/LoginController/OTPScreenController.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/BottomNavBarScreen.dart';

class OTPScreen extends GetView<OTPScreenController> {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    OTPScreenController controller = Get.put(OTPScreenController());
    return Scaffold(
      backgroundColor: AppTheme.screenBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.App_color,
        leading: IconButton(
            icon: const ImageIcon(AssetImage(
              "assets/icons/back_ios.png",
            )),
            color: AppTheme.primaryColor,
            iconSize: 18,
            onPressed: () {
              Get.back();
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       "assets/images/backgrountwo.png",
          //     ),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/Dr-Kanimozhi-min.png",
                  width: width * 0.9,
                  height: height * 0.3,
                  // color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width,
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Enter OTP".tr,
                        style: GoogleFonts.lato(
                          color: AppTheme.containerBackground,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                color: AppTheme.screenBackground,
                width: width * 0.88,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OtpInput(
                      controller: controller.fieldOne,
                      autoFocus: false,
                    ), // auto focus
                    OtpInput(controller: controller.fieldTwo, autoFocus: false),
                    OtpInput(
                        controller: controller.fieldThree, autoFocus: false),
                    OtpInput(
                      controller: controller.fieldFour,
                      autoFocus: false,
                    ),
                    OtpInput(
                        controller: controller.fieldFive, autoFocus: false),
                    OtpInput(
                        controller: controller.fieldSix,
                        autoFocus: false,
                        isNextFocus: false)
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              // Obx(
              //   () => Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // TextButton(
              //       //   child: Text(
              //       //     controller.showResendOTP.value
              //       //         ? "Re-Send Code".tr
              //       //         : "Re-Send Code ${controller.otpTimerSeconds.value.toString().padLeft(2, '0')} "
              //       //             .tr,
              //       //     style: TextStyle(
              //       //       fontSize: 15,
              //       //       color: AppTheme.primaryColor,
              //       //     ),
              //       //   ),
              //       //   onPressed: controller.showResendOTP.value
              //       //       ? () {}
              //       //       : null, // Disable button when countdown is active
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: const EdgeInsets.only(left: 0),
                  child: Obx(
                    () => Button(
                        widthFactor: 0.91,
                        heightFactor: 0.06,
                        onPressed: () {
                         // controller.verifyOTP();
                          controller.otpVerified();
                        },
                        child: controller.isLoading.value
                            ? Container(
                                height: height * 0.04,
                                width: height * 0.04,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text("Verify OTP".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

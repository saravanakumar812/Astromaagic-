import 'package:astromaagic/Routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Components/theme.dart';

import '../../Controller/Settings/SettingController.dart';

class Setting extends GetView<SettingController> {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SettingController controller = Get.put(SettingController());
    controller.context = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.editProfile();
      }
    });
    return Scaffold(
        backgroundColor: AppTheme.screenBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.App_color,
          // leading: IconButton(
          //     icon: const ImageIcon(AssetImage(
          //       "assets/icons/back_ios.png",
          //     )),
          //     color: AppTheme.primaryColor,
          //     iconSize: 18,
          //     onPressed: () {
          //       Get.back();
          //     }),
          title: Text(
            'Profile'.tr,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/backgroundImage.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: AssetImage(
                    //     'assets/images/logo.png',
                    //   ),
                    //   backgroundColor: Colors.yellow,
                    //   radius: 60,
                    // ),
                    Obx(() => controller.imageString.value.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(controller.imageString.value),
                            radius: 60,
                          )
                        : CircleAvatar(
                      backgroundImage:
                      NetworkImage('https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg'),
                      radius: 60,
                    )
                    ),
                    CircularPercentIndicator(
                      radius: 0,
                      lineWidth: 4,
                      percent: 0.85,
                      center: Text(
                        '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      progressColor: AppTheme.yellow,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.editProfile.toName);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Row(children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          child: Text(
                        "Edit Profile".tr,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                    ])),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  // launchUrl(
                  //   Uri.parse('https://astromaagic.us/' ), );
                  Get.offAllNamed(
                    AppRoutes.privacyPolicy.toName,
                  );
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Row(children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Icon(
                          Icons.privacy_tip,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          child: Text(
                        "Privacy Policy".tr,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                    ])),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  // launchUrl(
                  //   Uri.parse('https://astromaagic.us/' ), );
                  Get.offAllNamed(AppRoutes.supportScreen.toName);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Row(children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Icon(
                          Icons.support_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          child: Text(
                        "Support".tr,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                    ])),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  // launchUrl(
                  //   Uri.parse('https://astromaagic.us/' ), );
                  Get.offAllNamed(AppRoutes.faqScreen.toName);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Row(children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Icon(
                          Icons.question_answer,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          child: Text(
                        "FAQ".tr,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                    ])),
              ),
              SizedBox(
                height: 5,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Get.offAllNamed(AppRoutes.Login.toName);
              //   },
              //   child: Container(
              //       margin: EdgeInsets.only(left: 20, top: 10),
              //       child: Row(children: [
              //         Container(
              //           width: 40,
              //           height: 40,
              //           decoration: BoxDecoration(
              //               color: AppTheme.primaryColor,
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(30))),
              //           child: Icon(
              //             Icons.power_settings_new_rounded,
              //             size: 20,
              //             color: Colors.black,
              //           ),
              //         ),
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Container(
              //             child: Text(
              //           "Logout".tr,
              //           style: TextStyle(
              //               color: AppTheme.primaryColor,
              //               fontSize: 15,
              //               fontWeight: FontWeight.bold),
              //         ))
              //       ])),
              // ),
            ],
          ),
        ));
  }
}

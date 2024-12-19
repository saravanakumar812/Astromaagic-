import 'dart:ffi';

import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/forms.dart';

import '../../Components/theme.dart';
import '../../Controller/LanguageScreenController/LanguageScreenController.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/BottomNavBarScreen.dart';
import '../CountrySelection/CountrySelectionScreen.dart';
import '../LoginUI/RegisterScreen.dart';

class LanguageScreen extends GetView<LanguageScreenController> {
  LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LanguageScreenController controller = Get.put(LanguageScreenController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.screenBackground,
        body: Stack(
          children: [
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.only(right: 0),
            //     child: Image.asset(
            //       "assets/images/backgrountwo.png",
            //       height: MediaQuery.of(context).size.height,
            //       width: MediaQuery.of(context).size.width,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/language.png",
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Choose Language".tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Obx(() => GestureDetector(
                                onTap: () {
                                  controller.tamilOnclick.value =
                                      !controller.tamilOnclick.value;
                                  controller.englishOnclick.value = false;
                                  controller.hindiOnclick.value = false;
                                  print(
                                      "VALUES:${controller.localTamil[0]['locale']}");
                                  controller.updateLanguage(
                                      controller.localTamil[0]['locale']);
                                  AppPreference().updateLang('Tamil');
                                },
                                child: Container(
                                  width: width * 0.4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: controller.tamilOnclick.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: controller.tamilOnclick.value
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tamil",
                                      style: TextStyle(
                                        color: controller.tamilOnclick.value
                                            ? Colors.black
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Obx(() => GestureDetector(
                                onTap: () {
                                  controller.englishOnclick.value =
                                      !controller.englishOnclick.value;
                                  controller.tamilOnclick.value = false;
                                  controller.hindiOnclick.value = false;
                                  print(
                                      "VALUES:${controller.localEnglish[0]['locale']}");
                                  controller.updateLanguage(
                                      controller.localEnglish[0]['locale']);
                                  AppPreference().updateLang('English');
                                },
                                child: Container(
                                  width: width * 0.4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: controller.englishOnclick.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: controller.englishOnclick.value
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "English",
                                      style: TextStyle(
                                        color: controller.englishOnclick.value
                                            ? Colors.black
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Obx(() => GestureDetector(
                                onTap: () {
                                  controller.hindiOnclick.value =
                                      !controller.hindiOnclick.value;
                                  controller.englishOnclick.value = false;
                                  controller.tamilOnclick.value = false;

                                  print(
                                      "VALUES:${controller.localHindi[0]['locale']}");
                                  controller.updateLanguage(
                                      controller.localHindi[0]['locale']);
                                  AppPreference().updateLang('Hindi');
                                },
                                child: Container(
                                  width: width * 0.4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: controller.hindiOnclick.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: controller.hindiOnclick.value
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Hindhi",
                                      style: TextStyle(
                                        color: controller.hindiOnclick.value
                                            ? Colors.black
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.12,
                  ),

                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.44,
                  //   child: GridView.builder(
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       mainAxisSpacing: 5,
                  //       mainAxisExtent: 50,
                  //       childAspectRatio: 1.25,
                  //     ),
                  //     itemCount: controller.listValues.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Obx(() => LanguageSelectionAppTab(
                  //         title: controller.listValues[index].value,
                  //         isSelected:
                  //         controller.selectedTabIndex.value == index,
                  //         onClick: () {
                  //
                  //           controller.updateCurrentTabIndex(index);
                  //           if( controller.selectedTabIndex.value == 0){
                  //             controller.updateLanguage(controller.localEnglish[0]['locale']);
                  //           }  else if (controller.selectedTabIndex.value == 1){
                  //             controller.updateLanguage(controller.localTamil[0]['locale']);
                  //           } else if(controller.selectedTabIndex.value == 2){
                  //             controller.updateLanguage(controller.localHindi[0]['locale']);
                  //           }
                  //
                  //         },
                  //
                  //       ));
                  //     },
                  //   ),
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Button(
                            widthFactor: 0.85,
                            heightFactor: 0.06,
                            onPressed: () {
                              if (controller.englishOnclick.value == true ||
                                  controller.tamilOnclick.value == true ||
                                  controller.hindiOnclick.value == true) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             CountrySelectionScreen()));

                                Get.toNamed(AppRoutes.countryScreen.toName);

                                if (controller.englishOnclick.value == true) {
                                  AppPreference().updateLang("English");
                                } else if (controller.tamilOnclick.value ==
                                    true) {
                                  AppPreference().updateLang("Tamil");
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please Choose Language!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            child: Text("Next".tr,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ))),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

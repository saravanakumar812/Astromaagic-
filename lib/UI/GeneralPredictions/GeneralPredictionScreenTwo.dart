import 'package:astromaagic/Components/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenTwoController.dart';
import '../../Routes/app_routes.dart';
import 'GeneralPredictionScreenThree.dart';

class GeneralPredictionScreenTwo
    extends GetView<GeneralPredictionScreenTwoController> {
  const GeneralPredictionScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: AppTheme.screenBackground,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          "".tr,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[],
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundImage.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 23),
              width: width,
              height: 80,
              // color: Colors.red,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        child: Image.asset(
                          "assets/images/Group 841.png",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: width * 0.73,
                    height: 80,
                    // color: Colors.green,
                    child: Container(
                      width: width * 0.70,
                      height: 70,
                      //color: Colors.yellow,
                      margin: EdgeInsets.only(
                          right: 15, top: 10, left: 20, bottom: 3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'generalPredictions'.tr,
                                  maxLines: 1,
                                  style: GoogleFonts.lato(
                                    color: AppTheme.containerBackground,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Container(
                                      child: Image.asset(
                                    "assets/images/ratingbar.png",
                                    width: width * 0.3,
                                    color: AppTheme.primaryColor,
                                  )),
                                  Container(
                                    child: Text(
                                      '4.5+',
                                      maxLines: 1,
                                      style: GoogleFonts.lato(
                                        color: AppTheme.containerBackground,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: AppTheme.containerBackground,
                                  width: 1.0, // Underline thickness
                                ))),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Expanded(
                                    child: Text(
                                      "reviews".tr,
                                      style: GoogleFonts.lato(
                                        color: AppTheme.containerBackground,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "selectThe".tr,
                        style: GoogleFonts.lato(
                          color: AppTheme.containerBackground,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          //padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            //  borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          child: Text(
                            "communicationMode".tr,
                            style: GoogleFonts.lato(
                              color: AppTheme.appBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.04),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(GeneralPredictionScreenThree());
                  },
                  child: Container(
                    width: width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 40,
                          height: 25,
                          child: Image.asset("assets/images/pdf.png"),
                        ),
                        SizedBox(width: width * 0.04),
                        Text(
                          "solutionText".tr,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.generalPredictionVoiceMessage.toName);
                  },
                  child: Container(
                    width: width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 40,
                          height: 25,
                          child: Image.asset("assets/images/microphone.png"),
                        ),
                        SizedBox(width: width * 0.04),
                        Text(
                          "solutionVoice".tr,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 40,
                          height: 25,
                          child: Image.asset("assets/images/virtual.png"),
                        ),
                        SizedBox(width: width * 0.04),
                        Text(
                          "solutionVirtualMeeting".tr,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 40,
                          height: 25,
                          child: Image.asset("assets/images/solar.png"),
                        ),
                        SizedBox(width: width * 0.04),
                        Text(
                          "solutionMeeting".tr,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

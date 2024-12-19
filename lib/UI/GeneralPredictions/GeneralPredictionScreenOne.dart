import 'package:astromaagic/Components/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Components/forms.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenOneController.dart';
import '../../Controller/HomeController/HomeScreenController.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/BottomNavBarScreen.dart';
import 'GeneralPredictionScreenTwo.dart';

class GeneralPredictionScreenOne
    extends GetView<GeneralPredictionScreenOneController> {
  const GeneralPredictionScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: AppTheme.screenBackground,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => BottomNavBar()),
            //   (route) => false,
            // );
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
        child: SingleChildScrollView(
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
                                      color: AppTheme.white,
                                      fontSize: 20,
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
              Container(
                  margin: EdgeInsets.all(20),
                  width: width * 0.95,
                  height: height * 0.4,
                  //color: Colors.white,
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Text(
                        "predictions".tr,
                        style: GoogleFonts.lato(
                          color: AppTheme.containerBackground,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "solutionOptions".tr,
                  style: GoogleFonts.lato(
                    color: AppTheme.containerBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/circle.png",
                        width: 40,
                        height: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Text(
                      "solutionText".tr,
                      style: GoogleFonts.lato(
                        color: AppTheme.containerBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/circle.png",
                        width: 40,
                        height: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Text(
                      "solutionVoice".tr,
                      style: GoogleFonts.lato(
                        color: AppTheme.containerBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/circle.png",
                        width: 40,
                        height: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Text(
                      "solutionVoice".tr,
                      style: GoogleFonts.lato(
                        color: AppTheme.containerBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/circle.png",
                        width: 40,
                        height: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Text(
                      "solutionMeeting".tr,
                      style: GoogleFonts.lato(
                        color: AppTheme.containerBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Button(
                        widthFactor: 0.85,
                        heightFactor: 0.06,
                        onPressed: () {
                          Get.to(GeneralPredictionScreenTwo());
                        },
                        child: Text("getSolution".tr,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

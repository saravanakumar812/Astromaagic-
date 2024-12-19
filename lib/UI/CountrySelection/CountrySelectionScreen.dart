import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/CountrySelectionController/CountrySelectionController.dart';
import '../../Routes/app_routes.dart';


class CountrySelectionScreen extends GetView<CountrySelectionScreenController> {
  CountrySelectionScreen({super.key});

  CountrySelectionScreenController controller =
  Get.put(CountrySelectionScreenController());
  ScrollController scrollController = ScrollController();


  final List localEnglish = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  ];
  final List localTamil = [
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
  ];
  final List localKannada = [
    {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')},
  ];
  final List localHindi = [
    {'name': 'हिन्दी', 'locale': Locale('hi', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      if (controller.page.value < controller.totalpage.value) {
        controller.page.value++;
        controller.getAllCountries();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    scrollController.addListener(scrollListener);



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
                        "assets/images/country.png",
                        fit: BoxFit.contain,
                        width: width * 0.8,
                        height: height * 0.3,
                      ),
                      Container(
                        width: width,
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "Choose Your Country".tr,
                          style: GoogleFonts.lato(
                            color: AppTheme.containerBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: width / 2 - 25,
                            margin: EdgeInsets.fromLTRB(12, 14, 12, 0),
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() => InkWell(
                                  onTap: () {
                                    // controller.indiaController.text =
                                    // "India";
                                    // AppPreference()
                                    //     .updateCountry("India");
                                    controller.indiaOnclick.value =
                                    !controller
                                        .indiaOnclick.value;
                                    controller.otherOnclick.value =
                                    false;
                                    controller
                                        .countryController.text = "";
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: controller
                                          .indiaOnclick.value
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          15),
                                      // border: Border.all( color:controller
                                      //     .indiaOnclick.value
                                      //     ? AppTheme.primaryColor
                                      //     : Colors.white,width: 1.0),0
                                    ),
                                    height: 45,
                                    child: TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          controller.indiaOnclick.value =
                                          !controller
                                              .indiaOnclick.value;
                                          controller.otherOnclick.value =
                                          false;
                                          controller
                                              .countryController.text = "";
                                        },
                                        style: TextStyle(
                                            letterSpacing: 0.2,
                                            color: AppTheme.appBlack,
                                            fontWeight:
                                            FontWeight.w400,
                                            fontSize: 20),
                                        controller: controller
                                            .indiaController,
                                        decoration: InputDecoration(
                                          fillColor: controller
                                              .indiaOnclick.value
                                              ? AppTheme.primaryColor
                                              : Colors.white,
                                          filled: true,
                                          contentPadding:
                                          EdgeInsets.only(
                                            left: 40,
                                          ),
                                          hintText: "india".tr,
                                          hintStyle: TextStyle(
                                            fontSize: 20,
                                            color: AppTheme.labelColor,
                                          ),
                                          enabledBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            borderSide: BorderSide( color:controller
                                                .indiaOnclick.value
                                                ? AppTheme.primaryColor
                                                : Colors.white,width: 1.0),
                                          ),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            borderSide: BorderSide( color: controller
                                                .indiaOnclick.value
                                                ? AppTheme.primaryColor
                                                : Colors.white,width: 1.0),
                                          ),

                                        )),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Container(
                            width: width / 2 - 25,
                            margin: EdgeInsets.fromLTRB(12, 14, 12, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() => InkWell(
                                  onTap: () {
                                    AppPreference().updateCountry(
                                        controller
                                            .countryController.text);
                                    controller.otherOnclick.value =
                                    !controller
                                        .otherOnclick.value;
                                    controller.indiaOnclick.value =
                                    false;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: controller
                                          .otherOnclick.value
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          15),


                                    ),
                                    child: TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          _showBottomSheetCountry(
                                              context,
                                              controller
                                                  .countryController);
                                          controller.otherOnclick
                                              .value =
                                          !controller
                                              .otherOnclick.value;
                                          controller.indiaOnclick
                                              .value = false;
                                        },
                                        style: TextStyle(
                                            letterSpacing: 0.2,
                                            color: AppTheme.textColor,
                                            fontWeight:
                                            FontWeight.w400,
                                            fontSize: 20),
                                        controller: controller
                                            .countryController,
                                        decoration: InputDecoration(
                                          fillColor: controller
                                              .otherOnclick.value
                                              ? AppTheme.primaryColor
                                              : Colors.white,
                                          filled: true,
                                          contentPadding:
                                          EdgeInsets.only(
                                            left: 30,
                                          ),
                                          hintText: "others".tr,
                                          hintStyle: TextStyle(
                                            fontSize: 20,
                                            color: AppTheme.textColor,
                                          ),
                                          enabledBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            borderSide: BorderSide( color:controller
                                                .otherOnclick.value
                                                ? AppTheme.primaryColor
                                                : Colors.white,width: 1.0),
                                          ),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            borderSide: BorderSide( color: controller
                                                .otherOnclick.value
                                                ? AppTheme.primaryColor
                                                : Colors.white,width: 1.0),

                                          ),
                                          suffixIcon: Icon(
                                            Icons
                                                .arrow_drop_down_outlined,
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Button(
                            widthFactor: 0.85,
                            heightFactor: 0.06,
                            onPressed: () {
                              //
                              if(controller.indiaOnclick.value == true){
                                AppPreference().updateCountry('India');
                                Get.toNamed(AppRoutes.mobileNumberScreen.toName);
                                print(AppPreference().getCountry);
                              } else {
                                AppPreference().updateCountry(controller.countryController.text);
                                Get.toNamed(AppRoutes.mobileNumberScreen.toName);
                                print(AppPreference().getCountry);
                              }

                              // if (controller.countryController.text.isEmpty) {
                              //   Fluttertoast.showToast(
                              //     msg: "Please Enter Country",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.black,
                              //     textColor: Colors.white,
                              //   );
                              //   return;
                              // }

                              // AppPreference().updateCountry(
                              //     controller.countryController.text);
                              controller.userDataProvider
                                  .setIsFromForgotOrRegister("Register");
                              // Get.toNamed(AppRoutes.mobileNumberScreen.toName);
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

  void _showBottomSheetCountry(
      BuildContext context,
      TextEditingController controller,
      ) {
    CountrySelectionScreenController controller =
    Get.put(CountrySelectionScreenController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
        SingleChildScrollView(
        controller: scrollController,
        child: Container(
          margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
          padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.inputBorderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: AppTheme.screenBackground, // Set the desired background color
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: AppTheme.white,
                        size: 20,
                      ))
                ],
              ),
              IntrinsicHeight(
                child: Column(
                  children: List.generate(
                    controller.getAllCountry.length,
                        (index) {
                      var model = controller.getAllCountry[index];
                      return Container(
                        color: AppTheme.screenBackground,
                        child: Column(
                          children: [
                            Container(
                              color: AppTheme.screenBackground,
                              child: TextInput(
                                onPressed: () {
                                  controller.countryController.text =
                                  controller.getAllCountry[index].countryName!;
                                  // controller.indiaController.text =
                                  // controller.getAllCountry[index].countryName!;

                                  Navigator.pop(context);
                                },
                                margin: false,
                                isSelected: controller.countryController.text ==
                                    controller.getAllCountry[index].countryName,
                                label: "",
                                isEntryField: false,
                                textInputType: TextInputType.text,
                                textColor: AppTheme.white,
                                hintTextColor: AppTheme.white,
                                hintText: model.countryName,
                                obscureText: true,
                                onTextChange: (String) {},
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Visibility(
                                visible:
                                controller.getAllCountry.length != index + 1,
                                child: Container(
                                  height: 1,
                                  color: AppTheme.screenBackground,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
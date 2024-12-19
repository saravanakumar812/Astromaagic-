import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/forms.dart';
import '../Components/theme.dart';


class AppUtility {
  static double getHeight(var percentage) {
    return Get.height * (percentage / 100);
  }

  static double getWidth(var percentage) {
    return Get.width * (percentage / 100);
  }

  static sp(var i) {
    return Get.width / 100 * (i / 3);
  }

  static String serverError = 'Server Error, Try again later';
  static String noDataFound = 'No Data Found';
  static String offlineMessage = 'Your device goes offline';
  static String connectivityMessage =
      'Check your internet connection and try again';
  static String offlineDataMessage =
      'Data Saved Locally, it will be uploaded once your device back online';
  static String onlineMessage = 'Your device back online';
  static String evaluationConfirmationMessage =
      'This lead is not yet confirmed for Evaluation process.';
  static String evaluationCheckMessage =
      'Complete Basic Info section to proceed.';

  static Future<void> showSnackBar(String message) {
    if (message.isNotEmpty) {
      Get.rawSnackbar(message: message, duration: const Duration(seconds: 2));
      return Future.delayed(const Duration(seconds: 2));
    }
    return Future.value();
  }

  static Widget showProgressBar() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }


  static DateTime dobMinDate() {
    return DateTime(DateTime.now().year - 10);
  }

  static get commonShadow =>
       BoxShadow(color: AppTheme.borderShade1, blurRadius: 1);

  static get commonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        boxShadow: [commonShadow],
        border: Border.all(color: AppTheme.borderShade1),
        borderRadius: BorderRadius.circular(5),
      );


  static openCallApp(String phoneNumber) async {
    try {
      if (phoneNumber.isNotEmpty) {
        await launch("tel:${phoneNumber.trim()}");
      } else {
        AppUtility.showSnackBar("Phone Number is Empty");
      }
    } catch (e) {
      AppUtility.showSnackBar("Currently not supported");
    }
  }

  static openEmailApp(String email) async {
    try {
      if (email.isNotEmpty) {
        final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email.trim());
        await launch(emailLaunchUri.toString());
      } else {
        AppUtility.showSnackBar("Email is Empty");
      }
    } catch (e) {
      AppUtility.showSnackBar("Currently not supported");
    }
  }


  static dismissKeyboard() {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
    } catch (e) {}
  }

  Future<void> showYearMonthPicker(
      BuildContext context, TextEditingController textEditingController) async {
    RxString selectedMonthString =
    RxString(DateFormat("MMM").format(DateTime.now()));
    RxString selectedYearString =
    RxString(DateFormat("yy").format(DateTime.now()));
    RxInt selectedMonth = RxInt(DateTime.now().month);
    RxInt selectedYear = RxInt(DateTime.now().year);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 400.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 20, width: 20),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("Select Month",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.clear))
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.borderLightGrey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 15,
                        ),
                        onPressed: () {
                          selectedYear--;
                          selectedYearString.value =
                              selectedYear.toString().substring(2, 4);
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Obx(
                              () => Text(
                            selectedYear.toString(),
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.borderLightGrey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onPressed: () {
                          selectedYear++;
                          selectedYearString.value =
                              selectedYear.toString().substring(2, 4);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                    MediaQuery.of(context).size.shortestSide < 500
                        ? (.7 / .4)
                        : (.5 / .2),
                    crossAxisCount: 4,
                    crossAxisSpacing: 18.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: 12,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  itemBuilder: (BuildContext context, int index) {
                    int month = index + 1;
                    String monthName =
                    DateFormat('MMMM').format(DateTime(2020, month, 1));
                    selectedMonthString.value =
                        monthName.substring(0, 3).toString();
                    return InkWell(
                      onTap: () {
                        selectedMonth.value = index + 1;
                        selectedMonthString.value =
                            monthName.substring(0, 3).toString();
                      },
                      child: Obx(
                            () => Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            color: selectedMonthString.value ==
                                monthName.substring(0, 3)
                                ? AppTheme.secondaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: selectedMonthString.value ==
                                  monthName.substring(0, 3)
                                  ? AppTheme.secondaryColor
                                  : Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            monthName.substring(0, 3),
                            style: TextStyle(
                              color: selectedMonthString.value ==
                                  monthName.substring(0, 3)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton2(
                      width: width * 0.45,
                      height: 40,
                      title: 'Cancel',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Get.back();
                      },
                      color: Colors.white,
                      titleColor: AppTheme.bottomTabsLabelInActiveColor,
                      borderColor: AppTheme.cancelBorder,
                    ),
                    AppButton2(
                      width: width * 0.45,
                      height: 40,
                      title: 'Apply ',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        textEditingController.text =
                        "${selectedMonthString.value} ${selectedYearString.value}";

                        Get.back();
                      },
                      titleColor: Colors.white,
                      color: AppTheme.secondaryColor,
                      borderColor: AppTheme.secondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  static Future loader(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (context) => Center(
          child: PopScope(
            canPop: false,
            child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Lottie.asset("assets/images/Animation - 1713414492401.json",
                    fit: BoxFit.fitWidth, height: 50, width: 50)),
          )),
    );
  }


  // static Future loader(BuildContext context) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => Dialog(
  //       child: Center(
  //         child: Container(
  //             width: 100.0,
  //             height: 100.0,
  //             decoration: BoxDecoration(
  //               color: AppTheme.primaryColor,
  //               borderRadius: BorderRadius.circular(4.0),
  //             ),
  //             child: Lottie.asset("assets/images/Animation - 1713414492401.json",
  //                 fit: BoxFit.fitWidth, height: 50, width: 50)),
  //       ),
  //     ),
  //   );
  // }

}

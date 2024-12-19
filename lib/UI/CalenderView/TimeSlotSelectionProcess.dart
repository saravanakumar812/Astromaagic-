import 'package:intl/intl.dart';
import 'package:astromaagic/Routes/app_routes.dart';
import 'package:astromaagic/UI/HomeScreen/HomeScreen.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/CalenderViewController/TimeSlotProcessController.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenThreeController.dart';
import '../../Controller/VastuConsulting/VastuConsultingPriceSlotController.dart';
import '../../Provider/MenuDataProvider.dart';

class TimeSelectionProcessSlot extends GetView<TimeSelectionSlotController> {
  const TimeSelectionProcessSlot({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TimeSelectionSlotController controller =
        Get.put(TimeSelectionSlotController());
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.vastuPriceSlot();
        controller.getAllEvents();
      }
    });

    return Scaffold(
        backgroundColor: AppTheme.App_color,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  height: height * 0.065,
                  width: width * 0.33,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius:
                      BorderRadius.circular(10 // Adjust the radius as needed
                      ),
                      border: Border.all(color: AppTheme.white, width: 1)),
                  child: Center(
                    child: Text(
                      'Cancel'.tr,
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    for (int i = 0;
                    i < controller.remedyChargesListOnClick.length;
                    i++) {
                      if (controller.remedyChargesListOnClick[i] == true) {
                        controller.isClicked.value = true;
                      }
                    }
                    if (!controller.isClicked.value) {
                      Fluttertoast.showToast(
                        msg:  'CHOOSE YOUR TIME SLOT'.tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    }else{
                      controller.paymentProcess();
                    }
                  },
                  child: Container(
                    height: height * 0.065,
                    width: width * 0.33,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius:
                        BorderRadius.circular(10 // Adjust the radius as needed
                        ),
                        border: Border.all(color: AppTheme.primaryColor, width: 1)),
                    child: Center(
                      child: Text(
                        'Next'.tr,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                )
              ],),
            )

          ],
        ),

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
            'CHOOSE YOUR TIME SLOT'.tr,
            maxLines: 2,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[],
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: height * 0.8,
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
                      children: [
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  child: ListView.builder(
                                    itemCount: controller.dataList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return slotList(context, index);
                                    },
                                  ),
                                ),
                        ),
                        // Container(
                        //   height: height* 0.2,
                        //   margin: EdgeInsets.only(left: 70,right: 30),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         height: height * 0.065,
                        //         width: width * 0.33,
                        //         decoration: BoxDecoration(
                        //             color: AppTheme.white,
                        //             borderRadius:
                        //             BorderRadius.circular(10 // Adjust the radius as needed
                        //             ),
                        //             border: Border.all(color: AppTheme.white, width: 1)),
                        //         child: Center(
                        //           child: Text(
                        //             'Cancel',
                        //             maxLines: 2,
                        //             style: TextStyle(
                        //                 overflow: TextOverflow.ellipsis,
                        //                 fontSize: 18,
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.w300),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       GestureDetector(
                        //         onTap: () {
                        //           for (int i = 0;
                        //           i < controller.remedyChargesListOnClick.length;
                        //           i++) {
                        //             if (controller.remedyChargesListOnClick[i] == true) {
                        //               controller.isClicked.value = true;
                        //             }
                        //           }
                        //           if (!controller.isClicked.value) {
                        //             Fluttertoast.showToast(
                        //               msg: 'Please Select Slot',
                        //               toastLength: Toast.LENGTH_SHORT,
                        //               gravity: ToastGravity.BOTTOM,
                        //               backgroundColor: Colors.black,
                        //               textColor: Colors.white,
                        //             );
                        //           }else{
                        //             controller.paymentProcess();
                        //           }
                        //         },
                        //         child: Container(
                        //           height: height * 0.065,
                        //           width: width * 0.33,
                        //           decoration: BoxDecoration(
                        //               color: AppTheme.primaryColor,
                        //               borderRadius:
                        //               BorderRadius.circular(10 // Adjust the radius as needed
                        //               ),
                        //               border: Border.all(color: AppTheme.primaryColor, width: 1)),
                        //           child: Center(
                        //             child: Text(
                        //               'Next',
                        //               maxLines: 2,
                        //               style: TextStyle(
                        //                   overflow: TextOverflow.ellipsis,
                        //                   fontSize: 18,
                        //                   color: Colors.black,
                        //                   fontWeight: FontWeight.w300),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],),
                        // ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget slotList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var data = controller.dataList[index];
    return Obx(() => GestureDetector(
          onTap: () async {
            for (int i = 0;
                i < controller.remedyChargesListOnClick.length;
                i++) {
              if (index == i) {
                controller.remedyChargesListOnClick[index] =
                    !controller.remedyChargesListOnClick[index];
              } else {
                controller.remedyChargesListOnClick[i] = false;
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            width: width,
            height: height * 0.1,
            decoration: BoxDecoration(
                color: controller.remedyChargesListOnClick[index]
                    ? AppTheme.primaryColor
                    : AppTheme.screenBackground,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppTheme.primaryColor, width: 2)),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                       children: [
                         Text(
                           'Slot'.tr,
                           style: TextStyle(
                               fontSize: 18,
                               color: controller.remedyChargesListOnClick[index]
                                   ? Colors.black
                                   : AppTheme.primaryColor,
                               fontWeight: FontWeight.w600),
                         ),
                         Text(
                           ' - ${index + 1}',
                           style: TextStyle(
                               fontSize: 18,
                               color: controller.remedyChargesListOnClick[index]
                                   ? Colors.black
                                   : AppTheme.primaryColor,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                      Row(
                        children: [
                          Text(
                            'Duration: '.tr,
                            style: TextStyle(
                                fontSize: 13,
                                color:
                                    controller.remedyChargesListOnClick[index]
                                        ? Colors.white
                                        : AppTheme.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' 15 + 5 Mins'.tr,
                            style: TextStyle(
                                fontSize: 13,
                                color:
                                    controller.remedyChargesListOnClick[index]
                                        ? Colors.black
                                        : AppTheme.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat.jm()
                                .format(DateTime.parse(data.startTime ?? "")),
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    controller.remedyChargesListOnClick[index]
                                        ? Colors.white
                                        : AppTheme.white,
                                fontWeight: FontWeight.w600),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

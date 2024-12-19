import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:astromaagic/Routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenThreeController.dart';
import '../../Controller/VastuConsulting/VastuConsultingPaymentScreenController.dart';
import '../../Controller/VastuConsulting/VastuConsultingPriceSlotController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Utils/BottomNavBarScreen.dart';

class VastuConsultingPaymentScreen
    extends GetView<VastuConsultingPaymentScreenController> {
  const VastuConsultingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPaymentScreenController controller =
        Get.put(VastuConsultingPaymentScreenController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if(!controller.isApiCalled.value) {
      controller.vastuPriceSlot();
      controller.isApiCalled.value = true;
    }
    });
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
          'CONFIRM PAYMENT'.tr,
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
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              width: width,
              child: Text(
                controller.userDataProvider.getAllServicesData!.services
                    .toString(),
                maxLines: 1,
                style: GoogleFonts.lato(
                  color: AppTheme.containerBackground,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
              ),
              width: width,
              child: Text(
                controller.userDataProvider.getRemediesData!.remedy.toString(),
                maxLines: 1,
                style: GoogleFonts.lato(
                  color: AppTheme.containerBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
            // Container(
            //   margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            //   width: width,
            //   height: height * 0.15,
            //   decoration: BoxDecoration(
            //       color: AppTheme.screenBackground,
            //       borderRadius: BorderRadius.circular(5),
            //       border: Border.all(color: AppTheme.primaryColor, width: 2)),
            //   child: Row(
            //     children: [
            //       Container(
            //         margin: EdgeInsets.only(left: 15, top: 15, bottom: 20),
            //         width: width * 0.43,
            //         height: height * 0.15,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ? 'No Of Questions'.tr : 'Meeting Duration'.tr,
            //               style: TextStyle(
            //                   fontSize: 18,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //             Text(
            //               'fees'.tr,
            //               style: TextStyle(
            //                   fontSize: 18,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //           ],
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //           width: width * 0.43,
            //           height: height * 0.15,
            //           child: Container(
            //             margin: EdgeInsets.all(20),
            //             width: width * 0.45,
            //             height: height * 0.15,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 color: AppTheme.primaryColor,
            //                 border: Border.all(color: AppTheme.primaryColor, width: 2)),
            //             child: Container(
            //               margin: EdgeInsets.only(left: 15),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     controller.userDataProvider.getVastuData!
            //                             .noOfQuestions
            //                             .toString() ??
            //
            //                         "",
            //                     style: TextStyle(
            //                         fontSize: 14,
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.w800),
            //                   ),
            //                   Text(
            //                     '₹ ${controller.vastuData[0].fees}' ,
            //                    // controller.vastuData[index].fees.toString() ?? '',
            //                     style: TextStyle(
            //                         color: Colors.black,
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w800),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ) :
            Obx(
                  () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                child: ListView.builder(
                  itemCount: controller.vastuData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return slotList(context, index);
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.53,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Button(
                      widthFactor: 0.85,
                      heightFactor: 0.06,
                      onPressed: () {
                        controller.addUser();
                        //controller.openCheckOut();
                        // controller.razorpay.open(controller.getTurboPaymentOptions());
                      },
                      child: Text("Pay".tr,
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
      ),
    );
  }

  Widget slotList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPaymentScreenController controller =
        Get.put(VastuConsultingPaymentScreenController());
    return Obx(
      () => controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
      GestureDetector(
        onTap: () async {

        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          width: width,
          height: height * 0.1,
          decoration: BoxDecoration(
              color: AppTheme.screenBackground,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppTheme.primaryColor, width: 2)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30, top: 15, bottom: 20),
                width: width * 0.43,
                height: height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?

                    Text(
                      'fees'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color:  Colors.white,
                          fontWeight: FontWeight.w600),
                    ): Container()
                  ],
                ),
              ),


              GestureDetector(
                onTap: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.4,
                      height: height * 0.08,

                      child: Container(
                        margin: EdgeInsets.all(15),
                        width: width * 0.45,
                        height: height * 0.1,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:  AppTheme.primaryColor,
                            border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 2)),
                        child: Container(
                          //margin: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [




                              // controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
                              // Text(
                              //   "",
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       color:
                              //       Colors.black,
                              //       fontWeight: FontWeight.w800),
                              // ) :    Text(
                              //   controller.vastuData[index].meetingDuration
                              //       .toString(),
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       color:
                              //       Colors.black,
                              //       fontWeight: FontWeight.w800),
                              // ),


                           Text(
                                '₹ ${controller.vastuData[index].fees.toString()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                    Colors.black,
                                    fontWeight: FontWeight.w800),
                              ) ,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ) ,
            ],
          ),
        ),
      ) :    GestureDetector(
        onTap: () async {

        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          width: width,
          height: height * 0.15,
          decoration: BoxDecoration(
              color: AppTheme.screenBackground,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppTheme.primaryColor, width: 2)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 20),
                width: width * 0.43,
                height: height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
                    Text(
                      "" ,
                      style: TextStyle(
                          fontSize: 18,
                          color:  Colors.white,
                          fontWeight: FontWeight.w600),
                    ) :  Text(
                      'Meeting duration'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color:  Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'fees'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color:  Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?

              GestureDetector(
                onTap: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: width * 0.43,
                      height: height * 0.1,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: width * 0.45,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:  AppTheme.primaryColor,
                            border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 2)),
                        child: Container(
                          //margin: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [




                              // controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
                              // Text(
                              //   "",
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       color:
                              //       Colors.black,
                              //       fontWeight: FontWeight.w800),
                              // ) :    Text(
                              //   controller.vastuData[index].meetingDuration
                              //       .toString(),
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       color:
                              //       Colors.black,
                              //       fontWeight: FontWeight.w800),
                              // ),


                              Text(
                                '₹ ${controller.vastuData[index].fees.toString()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                    Colors.black,
                                    fontWeight: FontWeight.w800),
                              ) ,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ) :
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  width: width * 0.43,
                  height: height * 0.15,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: width * 0.45,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:  AppTheme.primaryColor,
                        border: Border.all(
                            color: AppTheme.primaryColor,
                            width: 2)),
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [




                          controller.userDataProvider.getRemediesData!.remedy == 'Text/PDF' ?
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                Colors.black,
                                fontWeight: FontWeight.w800),
                          ) :    Text(
                            controller.vastuData[index].meetingDuration
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                Colors.black,
                                fontWeight: FontWeight.w800),
                          ),


                          Text(
                            '₹ ${controller.vastuData[index].fees.toString()}',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                Colors.black,
                                fontWeight: FontWeight.w800),
                          ) ,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )

    );
  }

  static void UPIBottomSheet(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPaymentScreenController controller =
        Get.put(VastuConsultingPaymentScreenController());
    Get.bottomSheet(
        enableDrag: false,
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppTheme.screenBackground,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'UPI APP',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 30,
                      height: 18,
                      child: Image.asset("assets/images/cross.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => GestureDetector(
                onTap: () {
                  controller.googlePayOnclick.value =
                      !controller.googlePayOnclick.value;
                  controller.payamOnclick.value = false;
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 20,
                      height: 15,
                      child: Image.asset(
                        controller.googlePayOnclick.value
                            ? "assets/images/RadioButtonWithColor.png"
                            : "assets/images/RadioButton.png",
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Google Pay',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Obx(
              () => GestureDetector(
                onTap: () {
                  controller.payamOnclick.value =
                      !controller.payamOnclick.value;
                  controller.googlePayOnclick.value = false;
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 20,
                      height: 15,
                      child: Image.asset(
                        controller.payamOnclick.value
                            ? "assets/images/RadioButtonWithColor.png"
                            : "assets/images/RadioButton.png",
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Paytm',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Other UPI ID'.tr,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.45,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Enter UPI".tr,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Button(
                    widthFactor: 0.3,
                    heightFactor: 0.05,
                    onPressed: () {},
                    child: Text("Verify".tr,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ))),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Button(
                      widthFactor: 0.85,
                      heightFactor: 0.06,
                      onPressed: () {
                        // Get.toNamed(AppRoutes.successfullyPaidScreen.toName);
                       // controller.openCheckOut();
                      },
                      child: Text("Pay".tr,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ))),
                ),
              ],
            ),
          ]),
        ));
  }

  static void cardBottomSheet(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPaymentScreenController controller =
        Get.put(VastuConsultingPaymentScreenController());
    Get.bottomSheet(
        enableDrag: false,
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppTheme.screenBackground,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Enter card details',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 30,
                      height: 18,
                      child: Image.asset("assets/images/cross.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                  width: 30,
                  height: 18,
                  child: Image.asset("assets/images/note.png"),
                ),
                Text(
                  'Make sure your card is enable for online transactions',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Other UPI ID'.tr,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.45,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Enter UPI".tr,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Button(
                    widthFactor: 0.3,
                    heightFactor: 0.05,
                    onPressed: () {},
                    child: Text("Verify".tr,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ))),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Button(
                      widthFactor: 0.85,
                      heightFactor: 0.06,
                      onPressed: () {
                        // Get.toNamed(AppRoutes.successfullyPaidScreen.toName);
                       // controller.openCheckOut();
                      },
                      child: Text("Pay".tr,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ))),
                ),
              ],
            ),
          ]),
        ));
  }
}

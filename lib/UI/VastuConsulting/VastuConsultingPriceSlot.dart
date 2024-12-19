import 'package:astromaagic/Routes/app_routes.dart';
import 'package:astromaagic/UI/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenThreeController.dart';
import '../../Controller/VastuConsulting/VastuConsultingPriceSlotController.dart';
import '../../Provider/MenuDataProvider.dart';

class VastuConsultingPriceSlot
    extends GetView<VastuConsultingPriceSlotController> {
  const VastuConsultingPriceSlot({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPriceSlotController controller =
        Get.put(VastuConsultingPriceSlotController());
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.vastuPriceSlot();
      }
    });

    return Scaffold(
        backgroundColor: AppTheme.App_color,
        floatingActionButton: GestureDetector(
          onTap: () {
            // for (int i = 0;
            //     i < controller.remedyChargesListOnClick.length;
            //     i++) {
            //   if (controller.remedyChargesListOnClick[i] == true) {
            //     controller.isClicked.value = true;
            //
            //     Get.toNamed(AppRoutes.vastuConsultingPaymentScreen.toName);
            //   }
            // }
            //
            // if (!controller.isClicked.value) {
            //   Fluttertoast.showToast(
            //     msg: 'Please Select Payment',
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     backgroundColor: Colors.black,
            //     textColor: Colors.white,
            //   );
            // }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: Center(
              child: Text(
                'Pay',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(10)),
          ),
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
            'CHOOSE YOUR PRICE SLOT'.tr,
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
                          controller
                              .userDataProvider.getAllServicesData!.services
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
                          controller.userDataProvider.getRemediesData!.remedy
                              .toString(),
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
                    ],
                  ),
                ),
        ));
  }

  Widget slotList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingPriceSlotController controller =
        Get.put(VastuConsultingPriceSlotController());
    return Obx(() => GestureDetector(
          onTap: () async {
            // await controller.userDataProvider
            //     .setVastuData(controller.vastuData[index]);
            // for (int i = 0;
            //     i < controller.remedyChargesListOnClick.length;
            //     i++) {
            //   if (index == i) {
            //     controller.remedyChargesListOnClick[index] =
            //         !controller.remedyChargesListOnClick[index];
            //   } else {
            //     controller.remedyChargesListOnClick[i] = false;
            //   }
            // }
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            width: width,
            height: height * 0.15,
            decoration: BoxDecoration(
                color: controller.remedyChargesListOnClick[index]
                    ? AppTheme.primaryColor
                    : AppTheme.screenBackground,
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
                      Text(
                        controller.vastuData[index].noOfQuestions
                            .toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: controller.remedyChargesListOnClick[index]
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'fees'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            color: controller.remedyChargesListOnClick[index]
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  //   for (int i = 0;
                  //       i < controller.remedyChargesListOnClick.length;
                  //       i++) {
                  //     if (index == i) {
                  //       controller.remedyChargesListOnClick[index] =
                  //           !controller.remedyChargesListOnClick[index];
                  //     } else {
                  //       controller.remedyChargesListOnClick[i] = false;
                  //     }
                  //   }
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
                          color: controller.remedyChargesListOnClick[index]
                              ? AppTheme.screenBackground
                              : AppTheme.primaryColor,
                          border: Border.all(
                              color: controller.remedyChargesListOnClick[index]
                                  ? AppTheme.screenBackground
                                  : AppTheme.primaryColor,
                              width: 2)),
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             "",
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      controller.remedyChargesListOnClick[index]
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '₹ ${controller.vastuData[index].fees.toString()}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      controller.remedyChargesListOnClick[index]
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

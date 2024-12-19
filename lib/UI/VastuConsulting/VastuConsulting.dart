import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/VastuConsulting/VastuConsultingController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/AppPreference.dart';

class VastuConsulting extends GetView<VastuConsultingController> {
  const VastuConsulting({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    VastuConsultingController controller = Get.put(VastuConsultingController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.getParticularServices();
        controller.getRemedies();
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
            "".tr,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[],
          centerTitle: true,
        ),
        body: Container(
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/backgroundImage.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(
            () => controller.isLoading.value ||
                    controller.getParticularData == null
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          height: 70,
                          //color: Colors.yellow,
                          margin: EdgeInsets.only(
                              right: 25, top: 10, left: 25, bottom: 3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    controller.getParticularData!.services
                                            .toString() ??
                                        "",
                                    maxLines: 2,
                                    style: GoogleFonts.lato(
                                      color: AppTheme.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      child: Text(
                                        'Reviews'.tr,
                                        style: GoogleFonts.lato(
                                          color: AppTheme.containerBackground,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                              child: Text(
                                controller.getParticularData!.serviceDescription
                                    .toString(),
                                style: GoogleFonts.lato(
                                  color: AppTheme.containerBackground,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Select your remedy".tr,
                            style: GoogleFonts.lato(
                              color: AppTheme.containerBackground,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     print('ONPRESSED');
                        //     controller.userDataProvider
                        //         .setRemediesData(controller.remediesData[0]);
                        //     Get.toNamed(AppRoutes.vastuConsultingPriceSlot.toName);
                        //     },
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 20,
                        //       ),
                        //       Container(
                        //           width: 20,
                        //           height: 15,
                        //           child: Image.asset("assets/images/RadioButton.png")),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //            "Horoscope in text/pdf",
                        //           maxLines: 2,
                        //           style: GoogleFonts.lato(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     print('ONPRESSED');
                        //     controller.userDataProvider
                        //         .setRemediesData(controller.remediesData[1]);
                        //     Get.toNamed(AppRoutes.vastuConsultingPriceSlot.toName);
                        //   },
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 20,
                        //       ),
                        //       Container(
                        //           width: 20,
                        //           height: 15,
                        //           child: Image.asset("assets/images/RadioButton.png")),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //            "Consultation through voice message",
                        //           maxLines: 2,
                        //           style: GoogleFonts.lato(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     Container(
                        //         width: 20,
                        //         height: 15,
                        //         child: Image.asset("assets/images/RadioButton.png")),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //          "Consultation through Virtual Meeting",
                        //         maxLines: 2,
                        //         style: GoogleFonts.lato(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 16,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     Container(
                        //         width: 20,
                        //         height: 15,
                        //         child: Image.asset("assets/images/RadioButton.png")),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //         "Personalized Consultation with Dr. Kanimozhi",
                        //         maxLines: 2,
                        //         style: GoogleFonts.lato(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 16,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  child: ListView.builder(
                                    itemCount: controller.remediesData.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return remdiesList(context, index);
                                    },
                                  ),
                                ),
                        ),

                        SizedBox(
                          height: height * 0.06,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Center(
                        //       child: Button(
                        //           widthFactor: 0.85,
                        //           heightFactor: 0.06,
                        //           onPressed: () {
                        //             Get.offNamed(AppRoutes
                        //                 .vastuConsultingPriceSlot.toName);
                        //           },
                        //           child: Text("Proceed".tr,
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.w600,
                        //               ))),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: height * 0.2,
                        )
                      ],
                    ),
                  ),
          ),
        ));
  }

  Widget remdiesList(BuildContext context, int index) {
    VastuConsultingController controller = Get.put(VastuConsultingController());

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('ONPRESSED');
            controller.userDataProvider
                .setRemediesData(controller.remediesData[index]);
            // if(controller.remediesData[index] == 0){
            //   Get.toNamed(AppRoutes.vastuConsultingPriceSlot.toName);
            // }

            if(controller.remediesData[index].remedyId == 1){
              //Get.toNamed(AppRoutes.vastuConsultingPriceSlot.toName);
              Get.toNamed(AppRoutes.vastuConsultingPaymentScreen.toName);
            } else if (controller.remediesData[index].remedyId == 2){
              Get.toNamed(AppRoutes.calendlyView.toName);
            } else {
              Get.toNamed(AppRoutes.calendlyView.toName);
             // Get.toNamed(AppRoutes.vastuConsultingPaymentScreen.toName);
            }

          },
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                  width: 20,
                  height: 15,
                  child: Image.asset("assets/images/RadioButton.png")),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  controller.remediesData[index].remedy.toString() ?? "",
                  maxLines: 2,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

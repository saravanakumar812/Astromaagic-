import 'package:astromaagic/Components/theme.dart';
import 'package:astromaagic/ResponseModel/GetAllServicesResponse.dart';
import 'package:astromaagic/Routes/app_routes.dart';
import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Controller/HomeController/HomeScreenController.dart';
import '../../Provider/MenuDataProvider.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    HomeScreenController controller = Get.put(HomeScreenController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    controller.name.value = AppPreference().getUserName;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.getAllServices(context);
      }
      controller.userDataProvider.setIsFromZoomMeeting(false);
    });

    Future<void> onRefresh() async {
      controller.getAllServices(context);
    }

    return RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            color: AppTheme.App_color,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/backgroundImage.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: AppTheme.App_color,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppTheme.App_color,
                leadingWidth: 350,
                leading: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "welcome".tr,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            color: AppTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => Text(
                            "  ${controller.name.value}",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                              color: AppTheme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // actions: [
                //   IconButton(
                //       icon: const ImageIcon(
                //           AssetImage("assets/icons/statusIcon.png")),
                //       iconSize: 28,
                //       color: Colors.white,
                //       onPressed: () {
                //         Get.toNamed(AppRoutes.serviceHistory.toName);
                //       })
                // ]
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
                  () => controller.isLoading.value
                      ? Container()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 22, top: 0, bottom: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'words'.tr,
                                                  style: GoogleFonts.lato(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: ListView.builder(
                                  itemCount: controller.getServicesData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return controller.getServicesData[index]
                                                    .details !=
                                                null &&
                                            controller.getServicesData[index]
                                                .details!.isNotEmpty &&
                                            controller
                                                .getServicesData[index]
                                                .details![0]
                                                .bannerImage!
                                                .isNotEmpty
                                        ? CarouselSlider(
                                            carouselController:
                                                controller.controllerOne,
                                            items: controller
                                                .getServicesData[index].details!
                                                .map((imgUrl) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 130,
                                                    width: width,
                                                    margin: const EdgeInsets
                                                        .symmetric(

                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            imgUrl.bannerImage!,
                                                          ),
                                                          fit: BoxFit.fill,
                                                        )),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                                height: 170,
                                                aspectRatio: 2.0,
                                                scrollDirection: Axis.horizontal,
                                                viewportFraction: 0.88,
                                                enlargeCenterPage: true,
                                                enableInfiniteScroll: false,
                                                autoPlay: true,
                                                autoPlayInterval:
                                                    Duration(seconds: 3),
                                                autoPlayAnimationDuration:
                                                    Duration(milliseconds: 800),
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                                onPageChanged: (index, _) =>
                                                    controller
                                                        .updatePageIndicator(
                                                            index)),
                                          )
                                        : controller.getServicesData[index]
                                                        .details !=
                                                    null &&
                                                controller
                                                    .getServicesData[index]
                                                    .details!
                                                    .isNotEmpty
                                            ? Container(
                                                padding: EdgeInsets.all(10),
                                                // margin: EdgeInsets.only(left: 15,right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5, left: 15),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.42,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 20,
                                                            top: 20),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              controller
                                                                  .getServicesData[
                                                                      index]
                                                                  .details![0]
                                                                  .services
                                                                  .toString()
                                                                  .tr,
                                                              style: GoogleFonts
                                                                  .lato(
                                                                color: AppTheme
                                                                    .appBlack,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            // Image.asset(
                                                            //   "assets/images/logo.png",
                                                            //   height: 40,
                                                            //   color: Colors.black,
                                                            // ),
                                                            AppButton2(
                                                              width:
                                                                  width * 0.3,
                                                              height: 50,
                                                              title: "view".tr,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onPressed: () {
                                                                controller
                                                                    .userDataProvider
                                                                    .setAllServicesData(controller
                                                                        .getServicesData[
                                                                            index]
                                                                        .details![0]);

                                                                Get.toNamed(AppRoutes
                                                                    .vastuConsulting
                                                                    .toName);

                                                                // if (controller.getServicesData[index]
                                                                //         .services ==
                                                                //     '') {
                                                                //   Get.offNamed(AppRoutes
                                                                //       .generalPredictionScreenOne
                                                                //       .toName);
                                                                //
                                                                // } else if (controller
                                                                //         .getServicesData[index]
                                                                //         .services ==
                                                                //     'Vastu Consulting') {
                                                                //
                                                                // }
                                                              },
                                                              titleColor: AppTheme
                                                                  .containerBackground,
                                                              color: AppTheme
                                                                  .appBlack,
                                                              borderColor: AppTheme
                                                                  .primaryColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    controller
                                                                .getServicesData[
                                                                    index]
                                                                .details!
                                                                .length >
                                                            1
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 5,
                                                                    right: 15),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.42,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          20,
                                                                      top: 20),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller
                                                                        .getServicesData[
                                                                            index]
                                                                        .details![
                                                                            1]
                                                                        .services
                                                                        .toString()
                                                                        .tr,
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      color: AppTheme
                                                                          .appBlack,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  AppButton2(
                                                                    width:
                                                                        width *
                                                                            0.3,
                                                                    height: 50,
                                                                    title:
                                                                        "view"
                                                                            .tr,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .userDataProvider
                                                                          .setAllServicesData(controller
                                                                              .getServicesData[index]
                                                                              .details![1]);

                                                                      Get.toNamed(AppRoutes
                                                                          .vastuConsulting
                                                                          .toName);
                                                                    },
                                                                    titleColor:
                                                                        AppTheme
                                                                            .containerBackground,
                                                                    color: AppTheme
                                                                        .appBlack,
                                                                    borderColor:
                                                                        AppTheme
                                                                            .primaryColor,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              )
                                            : Container();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                ),
              )),
        ));
  }
}

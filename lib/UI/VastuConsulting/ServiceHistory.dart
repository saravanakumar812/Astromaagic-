import 'dart:io';

import 'package:astromaagic/UI/VastuConsulting/pdf_viewer_page.dart';
import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/VastuConsulting/ServiceHistoryController.dart';
import 'package:http/http.dart' as http;

import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';

class ServiceHistory extends GetView<ServiceHistoryController> {
  const ServiceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ServiceHistoryController controller = Get.put(ServiceHistoryController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(!controller.isCall) {
        // controller.isCall = true;
        controller.getUserServices();
      }
    });
    Future<void> onRefresh() async {
      controller.getUserServices();
    }

    return RefreshIndicator(
        onRefresh: onRefresh,
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.App_color,
        title: Text(
          'Service History',
          style: TextStyle(color: Colors.white),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? Container()

                    : Container(
                        child: ListView.builder(
                          itemCount: controller.servicesData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return servicesList(context, index);
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget servicesList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ServiceHistoryController controller = Get.put(ServiceHistoryController());
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            // controller.userDataProvider
            //     .setUserServicesData(controller.servicesData[index]);
            // // AppPreference().updateReamedyId(controller.servicesData[index].remedyId.toString());
            // if (controller.servicesData[index].remedyId.toString() == "1") {
            //   // controller.getViewPdf();
            //   final url = controller.getViewPdfData.pdf.toString();
            //   final file = await loadPdfFromNetwork(url);
            //
            //   openPdf(context, file, url);

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PdfViewerPage(
              //
              //     ),
              //   ),
              // );
            // } else {
            //   controller.scheduleMeeting();
            // }
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            width: width,
            // height: height * 0.15,
            decoration: BoxDecoration(
                color: AppTheme.screenBackground,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppTheme.primaryColor, width: 2)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.servicesData[index]!.services.toString() ??
                            "",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
    controller.servicesData[index]!.serviceStatus.toString() ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        controller.servicesData[index]!.remedy.toString() ?? "",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price: ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '₹${controller.servicesData[index]!.fees.toString() ?? ""}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        controller.servicesData[index]!.createdDateTime
                                .toString() ??
                            "",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: width * 0.27),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Text(
                      //         controller.servicesData[index]!.createdDateTime
                      //             .toString() ??
                      //             "",
                      //         style: TextStyle(
                      //             fontSize: 12,
                      //             color: AppTheme.primaryColor,
                      //             fontWeight: FontWeight.w400),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text(
                      //   controller.servicesData[index]!.createdDateTime
                      //           .toString() ??
                      //       "",
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       color: AppTheme.primaryColor,
                      //       fontWeight: FontWeight.w400),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWithoutBackground(
                            widthFactor: 0.3,
                            heightFactor: 0.035,
                            onPressed: () async {
                              controller.userDataProvider.setUserServiceData(
                                  controller.servicesData[index]);
                              Get.toNamed(AppRoutes.userServicesList.toName);
                              // AppPreference().updateReamedyId(controller.servicesData[index].remedyId.toString());
                              if (controller.servicesData[index].remedyId
                                      .toString() ==
                                  "1") {
                                // controller.getViewPdf();
                                // final url = controller.getViewPdfData.pdf.toString();
                                // final file = await loadPdfFromNetwork(url);
                                // openPdf(context, file, url);

                              } else {
                                // controller.scheduleMeeting();
                              }
                            },
                            child: Text("View".tr,
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  void openPdf(BuildContext context, File file, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(
          file: file,
          url: url,
        ),
      ),
    );
  }
}

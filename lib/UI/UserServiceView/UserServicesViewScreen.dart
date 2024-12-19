import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:http/http.dart' as http;
import '../../Controller/UserServiceViewController/UserServicesViewScreenController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';
import '../VastuConsulting/pdf_viewer_page.dart';

class UserServicesViewScreen
    extends GetView<UserServicesViewScreenController> {
  const UserServicesViewScreen({super.key});



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserServicesViewScreenController controller =
        Get.put(UserServicesViewScreenController());
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
controller.isLoading.value = false;

    return Scaffold(
        backgroundColor: AppTheme.App_color,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.App_color,
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
            'Service View',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body:   Obx(
        () => controller.isLoading.isFalse ?

        Container(
          height: height,
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.screenBackground,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.userDataProvider.getServiceData!.profileImage!.isEmpty ?

                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.screenBackground,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg'),
                      ),
                    ): CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(controller.userDataProvider.getServiceData!.profileImage!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 8),
                    child: Text(
                      controller.userDataProvider.getServiceData!.userName
                              .toString() ??
                          "",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 8),
                    child: Text(
                      controller
                              .userDataProvider.getServiceData!.createdDateTime
                              .toString() ??
                          "",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Requested Remedy :',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      controller.userDataProvider.getServiceData!.services
                              .toString() ??
                          "",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        '₹${controller.userDataProvider.getServiceData!.fees.toString() ?? ""}',
                        style: GoogleFonts.lato(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Selected Option :',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      controller.userDataProvider.getServiceData!.remedy
                              .toString() ??
                          "",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),
              controller.userDataProvider.getServiceData!.remedyId.toString() !=
                      "1"
                  ? Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Meet Date :',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          controller.userDataProvider.getServiceData
                                      ?.meetingDate
                                      .toString() !=
                                  null
                              ? Text(
                                  controller.userDataProvider.getServiceData!
                                          .meetingDate
                                          .toString() ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.primaryColor),
                                )
                              : Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.primaryColor),
                                )
                        ],
                      ),
                    )
                  : Container(),
              controller.userDataProvider.getServiceData!.remedyId.toString() !=
                      "1"
                  ? Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Time Slot :',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.userDataProvider.getServiceData!
                                    .meetingTime
                                    .toString() ??
                                "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor),
                          )
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.02,
                  ),
                  controller.userDataProvider.getServiceData!.remedyId.toString() ==
                      "1" &&  controller.userDataProvider.getServiceData!.horoscopePDF!.isNotEmpty ?      ButtonWithoutBackground(
                      widthFactor: 0.3,
                      heightFactor: 0.05,
                      onPressed: () async {

                        if (controller.userDataProvider.getServiceData!.remedyId.toString() ==
                            "1") {

                          final url = controller.userDataProvider.getServiceData!.horoscopePDF.toString();
                          final file = await loadPdfFromNetwork(url);
                          openPdf(context, file, url);

                        } else {
                         // controller.scheduleMeeting();
                        }
                      },
                      child: Text("View pdf".tr,
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ))) : Container(),
                ],
              ),
              // Container(
              //   height: 50,
              //   width: width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       border: Border.all(color:AppTheme.primaryColor)),
              //   margin: EdgeInsets.only(top: 8, left: 10, right: 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       pickFile(context);
              //     },
              //     child: Container(
              //       margin: EdgeInsets.symmetric(horizontal: 10),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text("Upload File",
              //               style: GoogleFonts.poppins(
              //                   color: Colors.white,
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.w600)),
              //           GestureDetector(
              //             onTap: () {
              //               pickFile(context);
              //             },
              //             child: Container(
              //               width: width * 0.3,
              //               margin: EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.all(Radius.circular(7)),
              //                   border: Border.all(color: AppTheme.primaryColor)),
              //               child: Center(
              //                 child: Text("Browser",
              //                     style: GoogleFonts.poppins(
              //                         color:AppTheme.primaryColor,
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.w600)),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: height * 0.02,),
              //
              // Container(
              // margin: EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("File Path",
              //           style: GoogleFonts.poppins(
              //               color: Colors.white,
              //               fontSize: 18,
              //               fontWeight: FontWeight.w600)),
              //
              //       GestureDetector(
              //         onTap: () {
              //           pickFile(context);
              //         },
              //         child: Container(
              //           width: width * 0.3,
              //           margin: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.all(Radius.circular(7)),
              //               border: Border.all(color: AppTheme.primaryColor)),
              //           child: Center(
              //             child: Text("Upload",
              //                 style: GoogleFonts.poppins(
              //                     color:AppTheme.primaryColor,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.w600)),
              //           ),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              // )
              
              
              // Button(
              //     widthFactor: 0.85,
              //     heightFactor: 0.06,
              //     onPressed: () {},
              //     child: Text("Accept".tr,
              //         style: GoogleFonts.lato(
              //           fontSize: 18,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w700,
              //         ))),
              // SizedBox(
              //   height: 15,
              // ),
              // ButtonWithoutBackground(
              //     widthFactor: 0.85,
              //     heightFactor: 0.06,
              //     onPressed: () {
              //       Get.back();
              //     },
              //     child: Text("Back".tr,
              //         style: GoogleFonts.lato(
              //           fontSize: 18,
              //           color: AppTheme.primaryColor,
              //           fontWeight: FontWeight.w700,
              //         ))),
            ],
          ),
        ) : Container()));
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




  pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Display the selected file path
        Get.snackbar(
          'File Selected',
          'Path: ${result.files.first.path}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else {
        // User canceled the file picker
        Get.snackbar(
          'File Picker',
          'User canceled file picking.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during file picking
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }
}

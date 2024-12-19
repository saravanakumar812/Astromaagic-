import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';

import '../../Controller/AdminServiceViewConrtroler/AdminServicesViewScreenController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';

class AdminServicesViewScreen
    extends GetView<AdminServicesViewScreenController> {
  const AdminServicesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AdminServicesViewScreenController controller =
        Get.put(AdminServicesViewScreenController());
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: AppTheme.App_color,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.App_color,
          leading: InkWell(
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => BottomNavBar()),
              //       (route) => false,
              // );
              Get.offNamed(AppRoutes.adminServicesList.toName);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: (width / 2) - 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primaryColor),
                                    borderRadius: BorderRadius.circular(5.5)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: AppTheme.App_color,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        hintText:
                                            controller.statusDropdown.value,
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme.white,
                                            fontSize: 12)),
                                    items: controller.listStatusData
                                        .map((material) {
                                      return DropdownMenuItem<String>(
                                        value: material,
                                        child: Text(
                                          material,
                                          style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      controller.statusDropdown.value = value!;
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      controller.userDataProvider.getServiceData!.profileImage!.isNotEmpty ?     Container(
                        margin: EdgeInsets.only(bottom: 10, left: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.screenBackground,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          NetworkImage(controller.userDataProvider.getServiceData!.profileImage!),
                        ),
                      ):
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
                          controller.userDataProvider.getServiceData!
                                  .createdDateTime
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
                    height: 0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
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
                        Expanded(
                          flex: 1,
                          child: Text(
                            controller.userDataProvider.getServiceData!.remedy
                                    .toString() ??
                                "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.userDataProvider.getServiceData!.remedyId
                              .toString() !=
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
                                          .toString() ==
                                      null
                                  ? Text(
                                      controller.userDataProvider
                                              .getServiceData!.meetingDate
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
                  controller.userDataProvider.getServiceData!.remedyId
                              .toString() !=
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
                  controller.userDataProvider.getServiceData!.remedyId
                      .toString() ==
                      "1" ?
                  Container(
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: AppTheme.primaryColor)),
                    margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        // pickFile(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Upload File",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                              onTap: () {
                                controller.pickFile(context);
                              },
                              child: Container(
                                width: width * 0.3,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    border: Border.all(
                                        color: AppTheme.primaryColor)),
                                child: Center(
                                  child: Text("Browser",
                                      style: GoogleFonts.poppins(
                                          color: AppTheme.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) : Container(),
                  Obx(() => controller.isFileSelected.value &&
                          controller.file != null
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // pickFile(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      border: Border.all(
                                          color: AppTheme.primaryColor)),
                                  child: Center(
                                    child: Text(
                                        controller.file!.path.split('/').last,
                                        style: GoogleFonts.poppins(
                                            color: AppTheme.primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.file = null;
                                  },
                                  child: Icon(Icons.clear))
                            ],
                          ),
                        )
                      : Container())
                ],
              ),
              Container(
                margin: EdgeInsets.all(20
                ),
                child: Obx(
                  () => Button(
                      widthFactor: 0.91,
                      heightFactor: 0.06,
                      onPressed: () {
                        if (controller.isLoading.value) {
                          return;
                        }
                        controller.updateStatus(context);
                      },
                      child: controller.isLoading.value
                          ? Container(
                              height: height * 0.04,
                              width: height * 0.04,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text("Update".tr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ))),
                ),
              ),
            ],
          ),
        ));
  }
}

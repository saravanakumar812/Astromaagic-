import 'package:astromaagic/ResponseModel/GetUserServiceResponse.dart';
import 'package:astromaagic/Routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/AppTab.dart';
import '../../Components/HorizontalScrollView.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/AdminServiceViewConrtroler/AdminServicesListController.dart';
import '../../Provider/MenuDataProvider.dart';

class AdminServicesList extends GetView<AdminServicesListController> {
  const AdminServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AdminServicesListController controller =
        Get.put(AdminServicesListController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserServices();
    });

    return Form(
      key: controller.formKey,
      child: Scaffold(
        backgroundColor: AppTheme.App_color,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.App_color,
          title: Text(
            'Service Request'.tr,
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
              child: Column(children: [
            Row(
              children: [
                Container(
                  width: (width / 2) - 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(5.5)),
                          child:  DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                key: controller.statusKey,
                                dropdownColor: AppTheme.App_color,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintText: controller.statusDropdown.value,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: AppTheme.white, fontSize: 12)),
                                items: controller.listStatusData.map((material) {
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
                Container(
                  width: (width / 2) - 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onTap: () {
                          DateTime now = DateTime.now();
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 250,
                                  child: CupertinoDatePicker(
                                    onDateTimeChanged: (DateTime newTime) {
                                      String date =
                                          "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                      controller.fromDateController.text = date;
                                    },
                                    minimumDate: DateTime(
                                        now.year - 104, now.month, now.day),
                                    maximumDate: DateTime(now.year, now.month,
                                        now.day, now.hour + 1),
                                    initialDateTime: DateTime.now(),
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                );
                              });
                        },
                        readOnly: true,
                        controller: controller.fromDateController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.5),
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.5),
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                          ),
                          hintText: 'From Date'.tr,
                          hintStyle: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.all(6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                            borderRadius: BorderRadius.circular(5.5),
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Container(
                  width: (width / 2) - 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onTap: () {
                          DateTime now = DateTime.now();
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 250,
                                  child: CupertinoDatePicker(
                                    onDateTimeChanged: (DateTime newTime) {
                                      String date =
                                          "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                      controller.toDateController.text = date;
                                    },
                                    minimumDate: DateTime(
                                        now.year - 104, now.month, now.day),
                                    maximumDate: DateTime(now.year, now.month,
                                        now.day, now.hour + 1),
                                    initialDateTime: DateTime.now(),
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                );
                              });
                        },
                        readOnly: true,
                        controller: controller.toDateController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.5),
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.5),
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                          ),
                          hintText: 'To Date'.tr,
                          hintStyle: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.all(6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.primaryColor),
                            borderRadius: BorderRadius.circular(5.5),
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (width / 2) - 21,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          // width: 250,
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(5.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                            key: controller.servicesKey,
                              dropdownColor: AppTheme.App_color,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  hintText: controller.servicesDropdown.value,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      //overflow: TextOverflow.clip,
                                      color: AppTheme.white,
                                      fontSize: 12)),
                              items: controller.listServicesData.map((material) {
                                return DropdownMenuItem<String>(
                                  value: material,
                                  child: Text(
                                    material,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.primaryColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                controller.servicesDropdown.value = value!;
                              },
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 0),
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
                ButtonWithoutBackground(
                    widthFactor: 0.27,
                    heightFactor: 0.055,
                    onPressed: () {
                      controller.toDateController.text = "";
                      controller.fromDateController.text = "";
                      // controller.formKey.currentState!.reset();
                      controller.statusKey.currentState!.reset();
                      // controller.servicesKey.currentState!.reset();

                      controller.servicesDropdown = RxString('Services');
                      controller.statusDropdown = RxString('Status');
                      controller.clearDropdownValue();
                      controller.getUserServices();
                    },
                    child: Text("Clear".tr,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ))),
                Button(
                    widthFactor: 0.27,
                    heightFactor: 0.055,
                    onPressed: () {
                      controller.getUserServices();
                    },
                    child: Text("Apply".tr,
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          color: AppTheme.white,
                          fontWeight: FontWeight.w700,
                        ))),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => HorizontalScrollView(
                children: List.generate(
                  controller.filterValues.length,
                  (index) {
                    var model = controller.filterValues[index];
                    return AppTab(
                        title: model.value,
                        isSelected: controller.selectedTabIndex.value == index,
                        onClick: () {
                          controller.selectedTabIndex.value = index;
                        });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Obx(
              () => Container(
                height: MediaQuery.of(context).size.height - 280,
                width: MediaQuery.of(context).size.width * 0.9,
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (controller.selectedTabIndex.value == 0)
                        controller.isLoading.value
                            ? Center()
                            : controller.servicesData.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.servicesData.length,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          controller.servicesData.length) {
                                        return servicesList(context, index,
                                            controller.servicesData[index]);
                                      } else if (controller.pageNum.value <
                                          controller.totalPage.value) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Center(
                                    child: Container(
                                      child: Image.asset(
                                        height: 250,
                                        width: 250,
                                        "assets/images/nodata.png",
                                      ),
                                    ),
                                  )
                      else if (controller.selectedTabIndex.value == 1)
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.servicesData.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.today.length,
                                    itemBuilder: (context, index) {
                                      if (index < controller.today.length) {
                                        return servicesList(context, index,
                                            controller.today[index]);
                                      } else if (controller.pageNum.value <
                                          controller.totalPage.value) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Center(
                                    child: Container(
                                      child: Image.asset(
                                        height: 250,
                                        width: 250,
                                        "assets/images/nodata.png",
                                      ),
                                    ),
                                  )
                      else if (controller.selectedTabIndex.value == 2)
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.servicesData.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.yesterday.length,
                                    itemBuilder: (context, index) {
                                      if (index < controller.yesterday.length) {
                                        return servicesList(context, index,
                                            controller.yesterday[index]);
                                      } else if (controller.pageNum.value <
                                          controller.totalPage.value) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Center(
                                    child: Container(
                                      child: Image.asset(
                                        height: 250,
                                        width: 250,
                                        "assets/images/nodata.png",
                                      ),
                                    ),
                                  )
                      else if (controller.selectedTabIndex.value == 3)
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.servicesData.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.lastWeek.length,
                                    itemBuilder: (context, index) {
                                      if (index < controller.lastWeek.length) {
                                        return servicesList(context, index,
                                            controller.lastWeek[index]);
                                      } else if (controller.pageNum.value <
                                          controller.totalPage.value) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Center(
                                    child: Container(
                                      child: Image.asset(
                                        height: 250,
                                        width: 250,
                                        "assets/images/nodata.png",
                                      ),
                                    ),
                                  )
                      else if (controller.selectedTabIndex.value == 4)
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.servicesData!.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.earlier.length,
                                    itemBuilder: (context, index) {
                                      if (index < controller.earlier.length) {
                                        return servicesList(context, index,
                                            controller.earlier[index]);
                                      } else if (controller.pageNum.value <
                                          controller.totalPage.value) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Center(
                                    child: Container(
                                      child: Image.asset(
                                        height: 250,
                                        width: 250,
                                        "assets/images/nodata.png",
                                      ),
                                    ),
                                  )
                    ],
                  ),
                ),
              ),
            )

            // Obx(
            //   () => controller.isLoading.value
            //       ? Container()
            //       : ListView.builder(
            //           itemCount: controller.servicesData.length,
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             return servicesList(context, index);
            //           },
            //         ),
            // ),
          ])),
        ),
      ),
    );
  }

  Widget servicesList(context, int index, UserServiceData model) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AdminServicesListController controller =
    Get.put(AdminServicesListController());

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.userDataProvider
                .setUserServiceData(controller.servicesData[index]);
            Get.offAllNamed(AppRoutes.adminServicesViewScreen.toName);
          },
          child: Container(
            //margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            width: width,
            //height: height * 0.16,
            decoration: BoxDecoration(
              color: AppTheme.screenBackground,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppTheme.primaryColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        model.profileImage!.isNotEmpty ?
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
                            radius: 20,
                            backgroundImage:
                            NetworkImage(model.profileImage!),
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
                      ],
                    ),
                    Container(
                      width: width * 0.43,
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18),
                          Container(
                            width: width * 0.7,
                            child: Text(
                              model.userName.toString() ?? "",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.9,
                            child: Text(
                              model.services.toString() ?? "",
                              style: GoogleFonts.lato(
                                color: AppTheme.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: Text(
                              model.remedy.toString() ?? "",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.createdDateTime.toString() ?? "",
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        model.serviceStatus.toString() ?? "",
                        maxLines: 1,
                        style: GoogleFonts.lato(
                          color: AppTheme.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(bottom: 0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       AppButton2(
                //         width: width * 0.2,
                //         height: 20,
                //         title: "view".tr,
                //         fontSize: 10,
                //         fontWeight: FontWeight.w600,
                //         onPressed: () {
                //           controller.userDataProvider
                //               .setUserServiceData(controller.servicesData[index]);
                //           Get.offAllNamed(
                //               AppRoutes.adminServicesViewScreen.toName);
                //         },
                //         titleColor: AppTheme.primaryColor,
                //         color: AppTheme.appBlack,
                //         borderColor: AppTheme.primaryColor,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       controller.servicesData[index].serviceStatus.toString() ==
                //               "Pending"
                //           ? AppButtonSmall(
                //               width: width * 0.21,
                //               height: 20,
                //               title: "Accept",
                //               fontSize: 10,
                //               fontWeight: FontWeight.w600,
                //               onPressed: () {
                //                 controller.userDataProvider.setUserServiceData(
                //                     controller.servicesData[index]);
                //                 controller.acceptService();
                //               },
                //               titleColor: AppTheme.appBlack,
                //               color: AppTheme.appBlack,
                //               borderColor: AppTheme.primaryColor,
                //             )
                //           : Container(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }


  void clearDropdownValue() {
    controller.statusDropdown.value = "";
  }
}

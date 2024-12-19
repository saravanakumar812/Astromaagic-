import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../Components/DateRangeExample.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/CalenderViewController/CalendlyViewController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Routes/app_routes.dart';

class CalendlyView extends GetView<CalendlyController> {
  CalendlyView({super.key});

  int _stackIndex = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendlyController controller = Get.put(CalendlyController());
    controller.context = context;
    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!controller.isCall) {
        controller.isCall = true;
        controller.getParticularServices();
        controller.getRemedies();
        controller.vastuPriceSlot();
      }
    });

    return Scaffold(
        backgroundColor: AppTheme.App_color,
        bottomSheet: Container(
          height: height * 0.6,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), // Adjust the radius as needed
              topRight: Radius.circular(15.0), // Adjust the radius as needed
            ),
          ),
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  // Adjust the radius as needed
                  topRight:
                      Radius.circular(15.0), // Adjust the radius as needed
                ),
              ),
              child: Obx(
                () => controller.isTimeApiCalled.value
                    ? Container(
                        height: 400,
                        child: Center(
                            child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator())),
                      )
                    : SfDateRangePicker(
                        controller: controller.pickerController,
                        showNavigationArrow: !controller.isTimeApiCalled.value,
                        allowViewNavigation: false,
                        navigationMode: DateRangePickerNavigationMode.none,
                        backgroundColor: Colors.white,
                        selectionColor: AppTheme.primaryColor,
                        selectionTextStyle:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        viewSpacing: 40,
                        headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        selectionMode: DateRangePickerSelectionMode.single,
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          DateTime res = args.value;
                          if (controller.availableDates.contains(res)) {
                            controller.selectedDateTime = res;
                            controller.selectedIndex =
                                controller.availableDates.indexOf(res);
                          }
                        },
                        onViewChanged: (DateRangePickerViewChangedArgs args) {
                          if (!controller
                              .shouldExecuteViewChangedCallback.value) {
                            controller.shouldExecuteViewChangedCallback.value =
                                true;
                            return;
                          }

                          controller.args = args;
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            if (controller.ableToCall == true &&
                                controller.isTimeApiCalled.isFalse) {
                              controller.shouldExecuteViewChangedCallback
                                  .value = false;
                              controller.getAllEventSlot(
                                  controller.args!.visibleDateRange.startDate!,
                                  controller.args!.visibleDateRange.endDate!);
                              print(
                                  'Current visible month: ${controller.args!.visibleDateRange.startDate}');
                            }
                            controller.ableToCall = true;
                          });
                          controller.ableToCall = true;
                        },
                        selectableDayPredicate: (DateTime val) =>
                            controller.availableDates.contains(val),
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                                dayFormat: 'EEE',
                                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                  backgroundColor: Colors.white,
                                )),
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          cellDecoration: BoxDecoration(shape: BoxShape.circle),
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          weekendTextStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          specialDatesDecoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              border: Border.all(color: Colors.red, width: 1),
                              shape: BoxShape.circle),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: height * 0.09,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.065,
                  width: width * 0.33,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(
                          10 // Adjust the radius as needed
                      ),
                      border: Border.all(color: Colors.grey, width: 1)),
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
                SizedBox(
                  width: width * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.selectedDateTime != null) {
                      controller.userDataProvider
                          .setSelectedMeetingTime(controller.selectedDateTime);
                      controller.userDataProvider.setSpots(
                          controller.days[controller.selectedIndex!].spots);

                      print(controller.selectedDateTime);
                      print(controller.selectedIndex);
                      print(controller.days[controller.selectedIndex!].spots);
                      if (controller.days[controller.selectedIndex!].spots ==
                              null ||
                          controller
                              .days[controller.selectedIndex!].spots!.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Slot are Not Available at this date".tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                        return;
                      }

                      Get.offNamed(AppRoutes.timeSelectionProcessSlot.toName);
                    }
                  },
                  child: Container(
                    height: height * 0.065,
                    width: width * 0.33,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(
                            10 // Adjust the radius as needed
                            ),
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 1)),
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
              ],
            )
          ])),
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
            'PICK YOUR SLOT'.tr,
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
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                controller.userDataProvider.getAllServicesData!
                                        .services
                                        .toString() ??
                                    "",
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
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //
                        //     children: [
                        //       Text(
                        //         '₹ ${controller.userDataProvider.getVastuData!.fees}' ,
                        //         maxLines: 2,
                        //         style: GoogleFonts.lato(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w800,
                        //           fontSize: 26,
                        //         ),
                        //       ),
                        //       Text(
                        //         controller.userDataProvider.getVastuData!.meetingDuration.toString(),
                        //         maxLines: 2,
                        //         style: GoogleFonts.lato(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
          ),
        ));
  }

  Widget slotList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendlyController controller = Get.put(CalendlyController());
    return Obx(() => GestureDetector(
          onTap: () async {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ ${controller.vastuData[index].fees.toString()}',
                  maxLines: 2,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                  ),
                ),
                Text(
                  controller.vastuData[index].meetingDuration.toString(),
                  maxLines: 2,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget remdiesList(BuildContext context, int index) {
    CalendlyController controller = Get.put(CalendlyController());

    return Column(
      children: [
        GestureDetector(
          onTap: () {},
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
                  controller.getParticularData!.services.toString() ?? "",
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

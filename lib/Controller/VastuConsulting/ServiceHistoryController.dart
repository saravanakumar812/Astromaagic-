import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:provider/provider.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';

import '../../ResponseModel/GetUserServiceResponse.dart';
import '../../ResponseModel/GetViewPdfResponse.dart';
import '../../ResponseModel/ScheduleMeetingResponse.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';

class ServiceHistoryController extends GetxController {
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxList<UserServiceData> servicesData = RxList();
  RxInt selectedIndex = RxInt(0);
  //RxList<GetViewPdfResponseData> getViewPdfData = RxList();
  GetViewPdfResponseData getViewPdfData = GetViewPdfResponseData();
  late BuildContext context;
  ScheduleMeetingResponseData meetingData = ScheduleMeetingResponseData();
  RxInt selectIndex = RxInt(0);
  bool isCall = false;
  @override
  void onInit() {
    super.onInit();
  }


  getViewPdf() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId':  '1',
    };
    isLoading.value = true;
    print("getPdfViewPayload:$payload");
    var response = await _connect.getViewPdfCall(payload);
    debugPrint("getPdfViewResponse: ${response.toJson()}");
    if (!response.error!) {
      getViewPdfData = response.data!;
      isLoading.value = false;
    } else {}
  }
  scheduleMeeting() async {
    print("scheduleFunction");
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId': servicesData[selectIndex.value].remedyId.toString(),
    };
    isLoading.value = true;
    AppUtility.loader(context);
    print("scheduleMeetingPayload:$payload");
    var response = await _connect.scheduleMeetingCall(payload);
    debugPrint("scheduleMeetingResponse: ${response.toJson()}");
    isLoading.value = false;
    Get.back();
    if (!response.error!) {
      meetingData = response.data!;
      userDataProvider.setMeetingData(meetingData );
      Get.toNamed(AppRoutes.calendlyView.toName);
    } else {}
  }
  getUserServices() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userId': AppPreference().getLoginUserId.toString(),
    };
    isLoading.value = true;
    AppUtility.loader(context);

    print("getUserServicesPayload:$payload");

    var response = await _connect.getUserServicesCall(payload);
    //debugPrint("getUserServicesResponse: ${response.toJson()}");
    log("getUserServicesResponseLog: ${response.toJson()}");
    Get.back();

    if (!response.error!) {
      servicesData.value = response.data!;

    } else {}
    isLoading.value = false;

  }
}

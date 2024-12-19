import 'package:astromaagic/ResponseModel/GetParticularServicesResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:provider/provider.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/GetRemediesResponse.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';

class VastuConsultingController extends GetxController {
  RxBool consultationVirtualMeeting = RxBool(false);
  RxBool personalizedConsultation = RxBool(false);
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  GetParticularData? getParticularData;
  bool isCall = false;
  RxList<bool> remediesListOnClick = RxList();
  RxList<GetRemediesData> remediesData = RxList();
  late BuildContext context;

  @override
  void onInit() {
    super.onInit();
  }

  getParticularServices() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'serviceId':
          userDataProvider.getAllServicesData!.serviceId.toString() ?? ''
    };
    isLoading.value = true;
    AppUtility.loader(context);
    print("getParticularServicesPayload:$payload");
    var response = await _connect.getParticularServicesCall(payload);
    debugPrint("getParticularServicesResponse: ${response.toJson()}");
    Get.back();
    if (!response.error!) {
      getParticularData = response.data;
      isLoading.value = true;
      isLoading.value = false;
    } else {}

  }

  getRemedies() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'serviceId':
          userDataProvider.getAllServicesData!.serviceId.toString() ?? ''
    };
    AppUtility.loader(context);
    print("getRemediesPayload:$payload");
    var response = await _connect.getRemediesServicesCall(payload);
    debugPrint("getRemediesPayloadResponse: ${response.toJson()}");
    Get.back();
    if (!response.error!) {
      remediesData.value = response.data!;
      for (int i = 0; i < response.data!.length; i++) {
        remediesListOnClick.add(false);
      }
    } else {}

    isLoading.value = true;
    isLoading.value = false;

  }
}

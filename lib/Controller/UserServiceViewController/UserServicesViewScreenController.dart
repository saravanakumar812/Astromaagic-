import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/GetViewPdfResponse.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';

class UserServicesViewScreenController extends GetxController {
  late MenuDataProvider userDataProvider;
  RxBool isLoading = RxBool(false);
  late BuildContext context;
  ApiConnect _connect = Get.put(ApiConnect());
  GetViewPdfResponseData getViewPdfData = GetViewPdfResponseData();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
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
}

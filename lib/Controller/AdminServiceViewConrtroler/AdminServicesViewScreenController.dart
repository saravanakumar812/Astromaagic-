import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Api_Config/ApiUrl.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/CommonResponse.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';

class AdminServicesViewScreenController extends GetxController {

  late MenuDataProvider userDataProvider;
  RxBool isLoading = RxBool(false);
  RxBool isFileSelected = RxBool(false);
  late BuildContext context;
  final ApiConnect _connect = Get.put(ApiConnect());
  List<String> listStatusData = ["Accepted", "In-Progress", "Completed"];
  RxString statusDropdown = RxString('Change Status');
  File? file;

  @override
  void onInit() {
    super.onInit();
  }

  acceptService() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userServiceId':
          userDataProvider.getServiceData!.userServiceId.toString(),
    };
    print('acceptServicePayload:$payload');
    isLoading.value = true;
    AppUtility.loader(context);
    var response = await _connect.acceptUserServiceCall(payload);
    debugPrint("acceptServiceResponse: ${response.toJson()}");
    Get.back();
    isLoading.value = false;
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offAllNamed(AppRoutes.adminServicesList.toName);
      // getUserServices();
    } else {}
  }

  Future<void> pickFile(BuildContext context) async {
    isFileSelected.value = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
    } else {}
    isFileSelected.value = true;
  }

  Future<void> updateStatus(context) async {
    Map<String, String> payload = {
      'userId': AppPreference().getLoginUserId.toString(),
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userServiceId':
          userDataProvider.getServiceData!.userServiceId.toString(),

    };
    if (statusDropdown.value != "Change Status") {
      Map<String, String> servicePayload = {
        "serviceStatus": statusDropdown.value == "Accepted"
            ? "1"
            : statusDropdown.value == "In-Progress"
                ? "2"
                : "3",
      };
      payload.addAll(servicePayload);
      print("UpdateStatus${payload}");
    } else {
      Map<String, String> servicePayload = {
        "serviceStatus": "",
      };
      payload.addAll(servicePayload);
      print("UpdateStatus${payload}");
    }

    isLoading.value = true;

    CommonResponse response;

    if (file == null) {
      response = await _connect.commonUpload(payload, ApiUrl.acceptUserService);
    } else {
      response =
          await _connect.fileUpload(ApiUrl.acceptUserService, file!, payload);
    }

    isLoading.value = false;

    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      Get.offAllNamed(AppRoutes.adminServicesList.toName);
    } else {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

}

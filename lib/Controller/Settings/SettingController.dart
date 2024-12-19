import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Api_Connect/ApiConnect.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';

class SettingController extends GetxController {
  RxString imageString = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  late BuildContext context;
  bool isCall = false;
  @override
  void onInit() {
    super.onInit();

  }
  Future<void> editProfile() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userId': AppPreference().getLoginUserId.toString(),
    };

    isLoading.value = true;

    var response = await _connect.getEditProfileCall(payload);

    isLoading.value = false;
    print("getParticularServicesPayload:$payload");
    debugPrint("EditProfilerResponse: ${response.toJson()}");
    imageString.value = response.data!.profileImage!;
  }
}

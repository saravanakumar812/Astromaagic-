import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/VastuPriceSlotResponse.dart';

class VastuConsultingPriceSlotController extends GetxController {
  RxBool consultationVirtualMeeting = RxBool(false);
  RxBool personalizedConsultation = RxBool(false);
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxList<VastuPriceSlotResponseData> vastuData = RxList();
  bool isCall = false;
  RxList<bool> remedyChargesListOnClick = RxList();
  RxBool isClicked = RxBool(false);
  Razorpay razorpay = Razorpay();
  @override
  void onInit() {
    super.onInit();

  }

  Future<void> vastuPriceSlot() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId': userDataProvider.getRemediesData!.remedyId.toString()
    };
    isLoading.value = true;
    print('VastuPriceSlotRequest$payload');
    var response = await _connect.vastuPriceSlot(payload);
    debugPrint("VastuPriceSlotResponse: ${response.toJson()}");
    if (!response.error!) {
      vastuData.value = response.data!;
      for (int i = 0; i < response.data!.length; i++) {
        remedyChargesListOnClick.add(false);
      }
    } else {}
    isLoading.value = false;

  }
}

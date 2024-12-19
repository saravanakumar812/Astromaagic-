import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/AvailableDateResponse.dart';
import '../../ResponseModel/GetAllEventNamesResponse.dart';
import '../../ResponseModel/VastuPriceSlotResponse.dart';
import '../../Routes/app_routes.dart';

class TimeSelectionSlotController extends GetxController {
  RxBool consultationVirtualMeeting = RxBool(false);
  RxBool personalizedConsultation = RxBool(false);
  late MenuDataProvider userDataProvider;
  RxBool isLoading = RxBool(false);
  bool isCall = false;
  ApiConnect _connect = Get.put(ApiConnect());

  RxList<bool> remedyChargesListOnClick = RxList();
  RxBool isClicked = RxBool(false);
  RxList<Spots> dataList = RxList();
  RxList<Events> getAllEventNames = RxList();
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  paymentProcess() async {
    for (int i = 0; i < remedyChargesListOnClick.length; i++) {
      if (remedyChargesListOnClick[i] == true) {
        isClicked.value = true;
        selectedIndex = i;
        break;
      }
    }

    if (isClicked.value == false) {
      Fluttertoast.showToast(
        msg: "Select the Time Slot",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, dynamic> payload = {
      "uuid": getAllEventNames[0].uuid.toString(),
      "meetingYearMonth": formatDate(
          DateTime.parse(dataList[selectedIndex].startTime ?? ""),
          [yyyy, '-', mm]),
      "meetingDate": formatDate(
          DateTime.parse(dataList[selectedIndex].startTime ?? ""),
          [yyyy, '-', mm, '-', dd]),
      "meetingDateTime": dataList[selectedIndex].startTime,
      'loginUserId': AppPreference().getLoginUserId.toString(),
    };

    isLoading.value = true;
    print("paymentRequest:$payload");
    var response = await _connect.scheduleEvent(payload);
    debugPrint("paymentResponse: ${response.toString()}");

    if (!response.error!) {
      userDataProvider.setEventURL(response.resource!.bookingUrl ?? "");
      userDataProvider.setIsFromZoomMeeting(true);
      Get.toNamed(AppRoutes.vastuConsultingPaymentScreen.toName);
      // Fluttertoast.showToast(
      //   msg: response.message!,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      // );


    } else {}
    isLoading.value = false;
  }

  Future<void> vastuPriceSlot() async {
    isLoading.value = true;
    var response = userDataProvider.getSpots;
    print(response);
    if (response != null) {
      dataList.value = response;
      for (int i = 0; i < response.length; i++) {
        remedyChargesListOnClick.add(false);
      }
    } else {}
    isLoading.value = false;
  }
  getAllEvents() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
    };

    var response = await _connect.getAllEventNames(payload);

    if (response.events != null) {

      getAllEventNames.value = response.events!;
      debugPrint("getAllCountryResponse: ${response.toJson()}");
      userDataProvider.setUuid(response.events![0].uuid);
    } else {}
  }
}

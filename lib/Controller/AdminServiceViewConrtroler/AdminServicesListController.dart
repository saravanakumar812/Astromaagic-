import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Api_Connect/ApiConnect.dart';
import '../../Components/Key.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Utils/AppPreference.dart';
import '../../Utils/app_utility.dart';
import '../../ResponseModel/GetUserServiceResponse.dart';

class AdminServicesListController extends GetxController {
  RxBool isLoading = RxBool(false);
  final GlobalKey<FormFieldState> statusKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> servicesKey = GlobalKey<FormFieldState>();

  final formKey = GlobalKey<FormState>();

  FocusNode statusKeyNode = FocusNode();
  FocusNode servicesKeyNode = FocusNode();

  RxString statusDropdown = RxString('Status'.tr);
  late BuildContext context;
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxList<UserServiceData> servicesData = RxList();
  RxList<UserServiceData> today = RxList();
  RxList<UserServiceData> lastWeek = RxList();
  RxList<UserServiceData> yesterday = RxList();
  RxList<UserServiceData> earlier = RxList();
  RxInt selectIndex = RxInt(0);
  RxString servicesDropdown = RxString('Services'.tr);
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  RxInt pageNum = RxInt(1);
  RxInt totalPage = RxInt(0);
  List<String> listStatusData = [
    "Accepted".tr,
    "In-Progress".tr,
    "Completed".tr,
    "Pending".tr
  ];
  RxInt selectedTabIndex = RxInt(0);
  List<String> listServicesData = [
    "Vastu Consulting".tr,
    "Personalized Horoscope".tr,
  ];
  void clearDropdownValue() {
   statusDropdown.value = "";
  }
  List<KeyValues> filterValues = [
    KeyValues(key: "0", value: "All".tr),
    KeyValues(key: "1", value: "Today".tr),
    KeyValues(key: "2", value: "Yesterday".tr),
    KeyValues(key: "3", value: "Last week".tr),
   // KeyValues(key: "4", value: "Earlier".tr),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  getUserServices() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      // 'userId': AppPreference().getLoginUserId.toString(),
    };
    if (statusDropdown.value != "Status".tr) {
      print(" values ${statusDropdown.value}");
      Map<String, String> servicePayload = {
        "serviceStatus": statusDropdown.value == "Accepted".tr
            ? "1"
            : statusDropdown.value == "In-Progress".tr
                ? "2"
                : statusDropdown.value == "Pending".tr
                    ? "0"
                    : "3",
      };
      payload.addAll(servicePayload);
    } else {
      Map<String, String> servicePayload = {
        "serviceStatus": "",
      };
      payload.addAll(servicePayload);
    }
    if (fromDateController.text.isNotEmpty) {
      Map<String, String> servicePayload = {
        "fromDate": fromDateController.text,
      };
      payload.addAll(servicePayload);
    }
    if (toDateController.text.isNotEmpty) {
      Map<String, String> servicePayload = {
        "toDate": toDateController.text,
      };
      payload.addAll(servicePayload);
    }
    if (servicesDropdown.value != "Services".tr) {
      Map<String, String> servicePayload = {
        "services": servicesDropdown.value,
      };
      payload.addAll(servicePayload);
    }else {
      Map<String, String> servicePayload = {
        "services": "",
      };
      payload.addAll(servicePayload);
    }

    isLoading.value = true;
    AppUtility.loader(context);

    print("getUserServicesPayload:$payload");
    var response = await _connect.getUserServicesCall(payload);
    debugPrint("getUserServicesResponse: ${response.toJson()}");
    Get.back();
    if (!response.error!) {
      servicesData.value = response.data!;
      isLoading.value = false;
    } else {}

    for (int i = 0; i < servicesData.length; i++) {
      if (servicesData[i].day == "Today".tr) {
        today.add(servicesData[i]);
      } else if (servicesData[i].day == "Yesterday".tr) {
        yesterday.add(servicesData[i]);
      } else if (servicesData[i].day == "Last week".tr) {
        lastWeek.add(servicesData[i]);
      } else if (servicesData[i].day == "Earlier".tr) {
        earlier.add(servicesData[i]);
      }
    }
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
      getUserServices();
    } else {}
  }
}

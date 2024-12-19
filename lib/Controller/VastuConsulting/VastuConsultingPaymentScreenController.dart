import 'package:intl/intl.dart';
import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/AddUserServiceResponse.dart';
import '../../ResponseModel/VastuPriceSlotResponse.dart';
import '../../Routes/app_routes.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Utils/app_utility.dart';
import '../../WebPage/WebPageScreen.dart';

class VastuConsultingPaymentScreenController extends GetxController {
  RxBool consultationVirtualMeeting = RxBool(false);
  RxBool personalizedConsultation = RxBool(false);
  RxBool indianRupeeOnclick = RxBool(false);
  RxBool usRupeeOnclick = RxBool(false);
  RxBool googlePayOnclick = RxBool(false);
  RxBool payamOnclick = RxBool(false);
  RxBool isApiCalled = RxBool(false);
  RxInt selectedTabIndex = 0.obs;
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxList<VastuPriceSlotResponseData> vastuData = RxList();
  RxList<VastuPriceSlotResponseData> vastuDataOne = RxList();
  RxList<AddUserServiceResponseData> paymentData = RxList();
  RxBool isLoading = RxBool(false);
  Razorpay razorpay = Razorpay();
  late BuildContext context;

  @override
  void onInit() {
    super.onInit();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success");
    paymentProcess(response.orderId.toString(), response.paymentId.toString(),
        response.signature.toString(), 1);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
    paymentProcess("", "", "", 0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  paymentProcess(
      String orderId, String paymentId, String signature, int status) async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userId': AppPreference().getLoginUserId.toString(),
      'orderId': orderId,
      'paymentId': paymentId,
      'signatures': signature,
      "paymentStatus": status,
    };
    isLoading.value = true;
    print("paymentRequest:$payload");
    var response = await _connect.getPaymentSuccess(payload);
    debugPrint("paymentResponse: ${response.toString()}");
    if (userDataProvider.getIsFromZoomMeeting!) {

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WenView(userDataProvider.getEventURL ?? "")));

    } else {
      Get.toNamed(AppRoutes.serviceHistory.toName);
    }
    if (!response.error!) {
      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      isLoading.value = false;
    } else {}
  }

  addUser() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userId': AppPreference().getLoginUserId.toString(),
      'serviceId':
          userDataProvider.getAllServicesData!.serviceId.toString() ?? '',
      'remedyId': userDataProvider.getRemediesData!.remedyId.toString(),
      // 'remedyChargeId': userDataProvider.getRemediesData!.remedy == 'Text/PDF'
      //     ? userDataProvider.getVastuData!.remedyChargeId
      //     : vastuData[0].remedyChargeId.toString(),
      // "fees": userDataProvider.getRemediesData!.remedy == 'Text/PDF'
      //     ? userDataProvider.getVastuData!.feesq
      //     : vastuData[0].fees.toString(),
      "remedyChargeId": vastuData[0].remedyChargeId.toString(),
      "fees": vastuData[0].fees.toString()
    };
    if (userDataProvider.getIsFromZoomMeeting!) {
      Map<String, dynamic> additional = {
        'meetingTime':
            DateFormat.jm().format(userDataProvider.selectedMeetingTime!),
        'meetingDate': formatDate(
            userDataProvider.selectedMeetingTime!, [yyyy, '-', mm, '-', dd]),
      };

      payload.addAll(additional);
    }
    isLoading.value = true;
    print("addUserPayload:$payload");
    Map<String, dynamic> response = await _connect.addUserCall(payload);
    debugPrint("addUserResponse: ${response.toString()}");
    final model = AddUserServiceResponse.fromJson(response);
    if (model != null) {
      if (model.data![0].status.toString() == "created") {
        var orderId = model.data![0].id.toString();
        var amount =  vastuData[0].fees.toString();//model.data![0].amount.toString();
        print("order Id ${orderId}");
        openCheckOut(orderId, amount);
        isLoading.value = false;
        // Get.toNamed(AppRoutes.serviceHistory.toName);
      }
    } else {}
  }

  void openCheckOut(String orderId, String amount) {
    var options = {
      'key': 'rzp_test_y7jlqVGKmyovVX',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Astro Maagic',
      'order_id': orderId, // Generate order_id using Orders API
      'description': '',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': AppPreference().getMobileNumber.toString(),
        'email': ''
      },
      'external': {
        'wallets': ['paytm']
      },
      'experiments.upi_turbo': true,
    };

    try {
      razorpay.open(options);

      // log(payment);
      // print(payment);
      // debugPrint(payment);
    } catch (e) {
      debugPrint("error : e");
    }
  }

  Future<void> vastuPriceSlot() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId': userDataProvider.getRemediesData!.remedyId.toString()
    };
    isLoading.value = true;
    AppUtility.loader(context);
    print('VastuPriceSlotRequest$payload');
    var response = await _connect.vastuPriceSlot(payload);
    debugPrint("VastuPriceSlotResponse: ${response.toJson()}");
    if (!response.error!) {
      vastuData.value = response.data!;
      // for (int i = 0; i < response.data!.length; i++) {
      //   remedyChargesListOnClick.add(false);
      // }
    } else {}
    Get.back();
    isLoading.value = false;
  }

  Future<void> vastuPriceSlotOne() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId': 1,
    };
    isLoading.value = true;
    AppUtility.loader(context);
    print('VastuPriceSlotRequestOne$payload');
    var response = await _connect.vastuPriceSlot(payload);
    debugPrint("VastuPriceSlotResponseOne: ${response.toJson()}");
    if (!response.error!) {
      vastuDataOne.value = response.data!;
      // for (int i = 0; i < response.data!.length; i++) {
      //   remedyChargesListOnClick.add(false);
      // }
    } else {}
    Get.back();
    isLoading.value = false;
  }
}

import 'package:astromaagic/Utils/AppPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path/path.dart';

import '../../Api_Config/ApiUrl.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Components/image_pickers.dart';
import '../../ResponseModel/CommonResponse.dart';
import '../../ResponseModel/GetEditProfileResponse.dart';
import '../../Utils/BottomNavBarScreen.dart';

class EditProfileScreenController extends GetxController {
  EditProfileResponseData? editData = EditProfileResponseData();
  Rx<PickedImage?> itemImage = Rx<PickedImage?>(null);
  RxList<PickedImage> productImages = RxList();
  RxBool isImageSelected = false.obs;
  RxString imageString = RxString("");
  RxBool isUpdateImageAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    editProfile();
  }

  RxBool married = RxBool(false);
  RxBool unMarried = RxBool(false);
  RxBool working = RxBool(false);
  RxBool business = RxBool(false);
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController timeOfBirthController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  RxString dateformat = RxString("");
  TextEditingController dateAndTimeController = TextEditingController();
  RxString selectedDate = RxString("");
  final ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxBool isUploading = RxBool(false);

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

    fullNameController.text = response.data!.userName!;
    dateOfBirthController.text = response.data!.dateOfBirth!;
    stateController.text = response.data!.stateOfBirth!;
    cityController.text = response.data!.cityOfBirth!;
    areaController.text = response.data!.areaOfBirth!;
    timeOfBirthController.text = response.data!.timeOfBirth!;
    marriageController.text = response.data!.maritalStatus! == "Married"
        ? response.data!.marriageDate!
        : "";
    response.data!.maritalStatus! == "Married"
        ? married.value = true
        : unMarried.value = true;
    response.data!.employment! == "Working"
        ? working.value = true
        : business.value = true;
    imageString.value = response.data!.profileImage!;
  }

  Future<void> updateProfile(context) async {
    Map<String, String> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'userId': AppPreference().getLoginUserId.toString(),
      "userName": fullNameController.text,
      "areaOfBirth": areaController.text,
      "cityOfBirth": cityController.text,
      "stateOfBirth": cityController.text,
      "dateOfBirth": dateOfBirthController.text,
      "timeOfBirth": timeOfBirthController.text,
      "maritalStatus": married.value == true ? "Married" : "unMarried",
      "marriageDate": married.value == true ? marriageController.text : "",
      "employment": working.value == true ? "Working" : "Business",
      "userLanguage": AppPreference().getLanguage,
      "userCountry": AppPreference().getCountry,
      "applicationType": "",
    };

    isUploading.value = true;

    CommonResponse response;

    if (itemImage.value == null) {
      response = await _connect.commonUpload(payload, ApiUrl.getUpdateProfile);
    } else {
      response = await _connect.imgUpdateCall(
          ApiUrl.getUpdateProfile, itemImage.value!.file!, payload);
    }

    isUploading.value = false;
    print("getUpdateProfilePayload:$payload");
    debugPrint("UpdateProfilerResponse: ${response.toJson()}");
    if (!response.error!) {

      AppPreference().updateUserName(fullNameController.text ?? "");

      Fluttertoast.showToast(
        msg: response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
      (route) => false,
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:astromaagic/ResponseModel/CommonResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import '../Api_Config/ApiUrl.dart';
import '../ResponseModel/AcceptUserServiceResponse.dart';
import '../ResponseModel/AvailableDateResponse.dart';
import '../ResponseModel/GetAllCountrysResponse.dart';
import '../ResponseModel/GetAllEventNamesResponse.dart';
import '../ResponseModel/GetAllServicesResponse.dart';
import '../ResponseModel/GetEditProfileResponse.dart';
import '../ResponseModel/GetParticularServicesResponse.dart';
import '../ResponseModel/GetRemediesResponse.dart';
import '../ResponseModel/GetUserServiceResponse.dart';
import '../ResponseModel/GetViewPdfResponse.dart';
import '../ResponseModel/HomeScreenResponseModel.dart';
import '../ResponseModel/MobileNumberResponse.dart';
import '../ResponseModel/OtpVerifyResponse.dart';
import '../ResponseModel/PaymentSuccessResponse.dart';
import '../ResponseModel/ScheduleMeetingResponse.dart';
import '../ResponseModel/ScheduleResponse.dart';
import '../ResponseModel/SignInResponse.dart';
import '../ResponseModel/SignUpResponse.dart';
import '../ResponseModel/UpdateProfile.dart';
import '../ResponseModel/VastuPriceSlotResponse.dart';
import '../Routes/app_routes.dart';
import '../Utils/AppPreference.dart';
import '../Utils/app_utility.dart';

class ApiConnect extends GetConnect {
  @override
  onInit() {
    super.allowAutoSignedCert = true;
    super.onInit();

    httpClient.addResponseModifier((request, response) {
      debugPrint("------------ AUTH ------------");
      debugPrint(
          "REQUEST METHOD: ${request.method} ; ENDPOINT:  ${request.url}");
      debugPrint("RESPONSE : ${response.bodyString}");
      return response;
    });
  }

  Future<SignInResponse> login(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.login, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return SignInResponse.fromJson(response.body);
  }

  Future<GetAllCountryResponse> getAllCountry(int pageNum) async {
    Map<String, dynamic> payload = {"dataPerPage": "250", "pageNo": pageNum};
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.all_country, formData);
    print("response");
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print(response.body);
    if (response.statusCode! > 400 && response.statusCode! > 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = GetAllCountryResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return GetAllCountryResponse.fromJson(response.body);
  }

  Future<SignUpResponse> register(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.add_users, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    if (response.statusCode! >= 400 && response.statusCode! > 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    var res = SignUpResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }



    return SignUpResponse.fromJson(response.body);
  }

  Future<CommonResponse> commonUpload(
      Map<String, dynamic> payload, String endpoint) async {
    FormData formData = FormData(payload);
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    var response = await post(ApiUrl.baseUrl + endpoint, formData, headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    if (response.statusCode! >= 400 && response.statusCode! > 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }  return CommonResponse.fromJson(response.body);
  } Future<SignUpResponse> registerUpload(
      Map<String, dynamic> payload, String endpoint) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + endpoint, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    if (response.statusCode! >= 400 && response.statusCode! > 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    var res = SignUpResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    return SignUpResponse.fromJson(response.body);
  }

  Future<HomeScreenResponse> getAllServicesCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getAllServices, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    print("body ${response.body}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
 }


    var res = HomeScreenResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    return HomeScreenResponse.fromJson(response.body);

  }
  // Future<GetAllServicesResponse> getAllServicesCall(
  //     Map<String, dynamic> payload) async {
  //   Map<String, String> header = {
  //     'Authorization': AppPreference().getToken.toString(),
  //     'loginUserId': AppPreference().getLoginUserId.toString(),
  //   };
  //   FormData formData = FormData(payload);
  //   var response = await post(ApiUrl.baseUrl + ApiUrl.getAllServices, formData,
  //       headers: header);
  //   if (response.body == null) throw Exception(AppUtility.connectivityMessage);
  //   return GetAllServicesResponse.fromJson(response.body);
  // }

  Future<GetAllServicesResponse> getFcmTokenCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getFcmTokenUpdate, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = GetAllServicesResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    return GetAllServicesResponse.fromJson(response.body);
  }

  Future<GetParticularServicesResponse> getParticularServicesCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.getParticularServices, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    var res = GetParticularServicesResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return GetParticularServicesResponse.fromJson(response.body);
  }

  Future<GetRemediesResponse> getRemediesServicesCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getRemedies, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    var res = GetRemediesResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return GetRemediesResponse.fromJson(response.body);
  }

  Future<VastuPriceSlotResponse> vastuPriceSlot(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.vastuPriceSlot, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = VastuPriceSlotResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    return VastuPriceSlotResponse.fromJson(response.body);
  }

  addUserCall(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.addUserService, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = VastuPriceSlotResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return response.body;
  }

  Future<GetUserServiceResponse> getUserServicesCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getUserService, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");


    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    var res = GetUserServiceResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }



    return GetUserServiceResponse.fromJson(response.body);
  }

  Future<GetViewPdfResponse> getViewPdfCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getViewPdf, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    var res = GetViewPdfResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return GetViewPdfResponse.fromJson(response.body);
  }

  Future<ScheduleResponse> scheduleEvent(Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };

    FormData formData = FormData(payload);
    var response = await post(
      ApiUrl.baseUrl + ApiUrl.scheduleEvent,
      formData,
        headers:header
    );
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    var res = ScheduleResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return ScheduleResponse.fromJson(response.body);
  }

  Future<MobileNumberResponse> forgotMobileNumberCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.forgotMobileNumber, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);

    var res = MobileNumberResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    return MobileNumberResponse.fromJson(response.body);
  }

  Future<PaymentSuccessResponse> getPaymentSuccess(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };

    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.paymentProcess, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    var res = PaymentSuccessResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return PaymentSuccessResponse.fromJson(response.body);
  }

  Future<ScheduleMeetingResponse> scheduleMeetingCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.scheduleMeeting, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = ScheduleMeetingResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return ScheduleMeetingResponse.fromJson(response.body);
  }

  Future<AvailableDateResponse> getAllEventSlot(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response =
        await post(ApiUrl.baseUrl + ApiUrl.getAllEventSlots, formData,headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = AvailableDateResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return AvailableDateResponse.fromJson(response.body);
  }


  Future<GetAllEventNamesResponse> getAllEventNames( Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
  var response = await post(ApiUrl.baseUrl + ApiUrl.getAllEventNames, formData ,headers: header);
  print("response");
  if (response.body == null) throw Exception(AppUtility.connectivityMessage);
  print(response.body);


    var res = GetAllEventNamesResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

  return GetAllEventNamesResponse.fromJson(response.body);
  }
  Future<EditProfileResponse> getEditProfileCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),

    };
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.getEditProfile, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = EditProfileResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }


    return EditProfileResponse.fromJson(response.body);
  }

  Future<UpdateProfileResponse> getUpdateProfileCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.getUpdateProfile, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");

    var res = UpdateProfileResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."  || res.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return UpdateProfileResponse.fromJson(response.body);
  }

  Future<AcceptUserServiceResponse> acceptUserServiceCall(
      Map<String, dynamic> payload) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };

    FormData formData = FormData(payload);
    var response = await post(
        ApiUrl.baseUrl + ApiUrl.acceptUserService, formData,
        headers: header);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    var res = AcceptUserServiceResponse.fromJson(response.body);
    if(res.message == "Bearer token is expired."   || res.message == "Enter a valid bearer token." ){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return AcceptUserServiceResponse.fromJson(response.body);
  }

  Future<OtpVerifyResponse> otpVerifyCall(Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.otpVerify, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return OtpVerifyResponse.fromJson(response.body);
  }

  Future<MobileNumberResponse> mobileNumberCall(
      Map<String, dynamic> payload) async {
    FormData formData = FormData(payload);
    var response = await post(ApiUrl.baseUrl + ApiUrl.mobileNumber, formData);
    if (response.body == null) throw Exception(AppUtility.connectivityMessage);
    return MobileNumberResponse.fromJson(response.body);
  }

  Future<CommonResponse> imgUpdateCall(
    String url,
    XFile? imageFile,
    Map<String, String> payload,
  ) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };
    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));
    // var response = await post(
    //     ApiUrl.baseUrl + ApiUrl.getUpdateProfile,
    //     headers: header);
    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile(
          'profileImage', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    request.fields.addAll(payload);
    request.headers.addAll(header);
    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return CommonResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = CommonResponse.fromJson(parsedResponse);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400  &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    return convertedResponse;
  }

  Future<SignUpResponse> imgRegisterCall(
    String url,
    XFile? imageFile,
    Map<String, String> payload,
  ) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
      'loginUserId': AppPreference().getLoginUserId.toString(),
    };
    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url));
    // var response = await post(
    //     ApiUrl.baseUrl + ApiUrl.getUpdateProfile,
    //     headers: header);
    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile(
          'profileImage', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }
    request.fields.addAll(payload);
    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return SignUpResponse();
    }
    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = SignUpResponse.fromJson(parsedResponse);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }
    return convertedResponse;
  }

  Future<CommonResponse> fileUpload(
    String url,
    File? imageFile,
    Map<String, String> payload,
  ) async {
    Map<String, String> header = {
      'Authorization': AppPreference().getToken.toString(),
    };

    print("URL$url");
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.baseUrl + url ));
    // var response = await post(
    //     ApiUrl.baseUrl + ApiUrl.getUpdateProfile,
    //     headers: header);
    if (imageFile != null) {
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile(
          'horoscopePDF', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    request.fields.addAll(payload);
    request.headers.addAll(header);
    // Send the request
    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    debugPrint("responseBody : ${responseBody}");

    var parsedResponse;

    try {
      parsedResponse = json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      return CommonResponse();
    }

    debugPrint("url : ${url}");
    debugPrint("imageFile : ${parsedResponse}");

    var convertedResponse = CommonResponse.fromJson(parsedResponse);
    print("Status_Code ${response.statusCode}");
    if (response.statusCode! >= 400 &&
        response.statusCode! < 500) {
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    if(convertedResponse.message == "Bearer token is expired."  || convertedResponse.message == "Enter a valid bearer token."){
      AppPreference().clearData();
      Get.offAllNamed(AppRoutes.Login.toName);
    }

    return convertedResponse;
  }
}

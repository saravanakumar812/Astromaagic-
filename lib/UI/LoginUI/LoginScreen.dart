import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../../Api_Config/ApiUrl.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/LoginController/LoginController.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../Utils/AppPreference.dart';
import '../LanguageScreen/LanguageScreen.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LoginController controller = Get.put(LoginController());

    controller.userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    return MaterialApp(
      localizationsDelegates: [CountryLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppTheme.screenBackground,
        body: Container(
          height: height,
          width: width,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       "assets/images/backgrountwo.png",
          //     ),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/Dr-Kanimozhi-min.png",
                      width: width * 0.9,
                      height: height * 0.3,
                      // color: Colors.white,
                    ),
                  ),
                  Container(
                    width: width,
                    child: Text(
                      "welcome".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: AppTheme.containerBackground,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),

                  Container(
                    width: width * 0.93,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                        children: [
                      Container(
                        width: 100,
                        height: 40,
                        // color: AppTheme.white,
                        child: CountryCodePicker(
                          padding: EdgeInsets.zero,
                          textStyle: TextStyle(
                              color: AppTheme.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          searchStyle: TextStyle(color: Colors.black),
                          dialogTextStyle: TextStyle(color: Colors.black),
                          hideMainText: false,
                          showFlagMain: true,
                          showFlag: true,
                          flagWidth: 40,
                          initialSelection: 'IN',
                          hideSearch: false,
                          showCountryOnly: false,
                          showFlagDialog: true,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          enabled: true,
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 30, color: AppTheme.white),
                      ),
                      Expanded(
                          child: Container(
                            //padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: controller.mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter your mobile number".tr,
                                hintStyle: const TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                contentPadding: const EdgeInsets.only(left: 20),
                              ),
                              //  border: OutlineInputBorder(
                              //   borderSide:
                              //   BorderSide(width: 2, color: AppTheme.primaryColor),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              //     ),
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0,
                                  color: AppTheme.containerBackground,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ))
                    ]),
                  ),

                  // Container(
                  //   width: width * 0.93,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     border: Border.all(
                  //       color: AppTheme.primaryColor,
                  //     ),
                  //   ),
                  //   child: InternationalPhoneNumberInput(
                  //     selectorButtonOnErrorPadding: 10,
                  //     spaceBetweenSelectorAndTextField: 5,
                  //     textStyle: TextStyle(color: Colors.white),
                  //     onInputChanged: (PhoneNumber number) {
                  //       controller.phoneNumber = number;
                  //       //   controller.mobileController.text = controller.formatMobileNumber(number.phoneNumber.toString());
                  //       //controller.mobileController.text = number.toString();
                  //       //    print(number.phoneNumber);
                  //     },
                  //     onInputValidated: (bool value) {
                  //       print(value);
                  //     },
                  //     selectorConfig: SelectorConfig(
                  //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  //       useBottomSheetSafeArea: true,
                  //     ),
                  //     ignoreBlank: false,
                  //     autoValidateMode: AutovalidateMode.disabled,
                  //     selectorTextStyle: TextStyle(color: Colors.white),
                  //     initialValue: controller.phoneNumber,
                  //     textFieldController: controller.mobileController,
                  //     formatInput: true,
                  //     keyboardType: TextInputType.numberWithOptions(
                  //         signed: true, decimal: true),
                  //     inputBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(5)),
                  //       borderSide: BorderSide(
                  //         color: AppTheme.primaryColor,
                  //       ),
                  //     ),
                  //     inputDecoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(top: 22, bottom: 10),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(5)),
                  //           borderSide: BorderSide(
                  //             color: AppTheme.screenBackground,
                  //           )),
                  //       disabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(5)),
                  //           borderSide: BorderSide(
                  //             color: AppTheme.screenBackground,
                  //           )),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         borderSide: BorderSide(
                  //           color: AppTheme.screenBackground,
                  //         ),
                  //       ),
                  //       hintText: "Enter Your Mobile Number".tr,
                  //       hintStyle: const TextStyle(
                  //           fontSize: 16.0,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w400),
                  //       counterStyle: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     onSaved: (PhoneNumber number) {
                  //       print('On Saved: $number');
                  //     },
                  //   ),
                  // ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: AppTheme.screenBackground,
                  //       borderRadius: BorderRadius.all(Radius.circular(5))),
                  //   child: TextFormField(
                  //     controller: controller.mobileController,
                  //     keyboardType: TextInputType.phone,
                  //     decoration: InputDecoration(
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(width: 1, color: AppTheme.primaryColor),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         borderSide:
                  //             BorderSide(width: 1, color: AppTheme.primaryColor),
                  //       ),
                  //       hintText: "Enter Your Mobile Number".tr,
                  //       hintStyle: const TextStyle(
                  //           fontSize: 16.0,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w400),
                  //       contentPadding: const EdgeInsets.only(left: 20),
                  //       border: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(width: 2, color: AppTheme.primaryColor),
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //     ),
                  //     style: TextStyle(
                  //         decoration: TextDecoration.none,
                  //         decorationThickness: 0,
                  //         color: AppTheme.containerBackground,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.screenBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Obx(()=> TextFormField(
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.oldPass.value,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppTheme.primaryColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              width: 1, color: AppTheme.primaryColor),
                        ),
                        hintText: "Enter your mobile password".tr,
                        hintStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        contentPadding: const EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon:
                        InkWell(
                          onTap: () {

                            controller.oldPass.value = !controller.oldPass.value;

                          },
                          child: Icon(
                              controller.oldPass.value ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
                        ),
                      ),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                          color: AppTheme.containerBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    child: InkWell(
                      onTap: () {
                        controller.forgot();
                      },
                      child: Text(
                        "forgot password".tr,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.lato(
                          color: AppTheme.containerBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    child: Obx(
                          () => Button(
                          widthFactor: 0.91,
                          heightFactor: 0.06,
                          onPressed: () {
                            if (controller.isLoading.value) {
                              return;
                            }
                            controller.loginCall(context);
                          },
                          child: controller.isLoading.value
                              ? Container(
                              height: height * 0.04,
                              width: height * 0.04,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ))
                              : Text("login".tr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppTheme.containerBackground,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: () {
                            Get.off(() => LanguageScreen(),
                                transition: Transition.rightToLeft);
                          },
                          child: Text(
                            "Register".tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: AppTheme.containerBackground,
                              fontSize: 14,
                              textStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryColor),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choose Language".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.tamilOnclick.value =
                          !controller.tamilOnclick.value;
                          controller.englishOnclick.value = false;
                          controller.hindiOnclick.value = false;
                          print(
                              "VALUES:${controller.localTamil[0]['locale']}");
                          controller.updateLanguage(
                              controller.localTamil[0]['locale']);
                          AppPreference().updateLang('Tamil');
                        },
                        child: Container(
                          width: width * 0.25,
                          height: 40,
                          decoration: BoxDecoration(
                            color: controller.tamilOnclick.value
                                ? AppTheme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.tamilOnclick.value
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Tamil",
                              style: TextStyle(
                                color: controller.tamilOnclick.value
                                    ? Colors.black
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.englishOnclick.value =
                          !controller.englishOnclick.value;
                          controller.tamilOnclick.value = false;
                          controller.hindiOnclick.value = false;
                          print(
                              "VALUES:${controller.localEnglish[0]['locale']}");
                          controller.updateLanguage(
                              controller.localEnglish[0]['locale']);
                          AppPreference().updateLang('English');
                        },
                        child: Container(
                          width: width * 0.25,
                          height: 40,
                          decoration: BoxDecoration(
                            color: controller.englishOnclick.value
                                ? AppTheme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.englishOnclick.value
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "English",
                              style: TextStyle(
                                color: controller.englishOnclick.value
                                    ? Colors.black
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.hindiOnclick.value =
                          !controller.hindiOnclick.value;
                          controller.englishOnclick.value = false;
                          controller.tamilOnclick.value = false;

                          print(
                              "VALUES:${controller.localHindi[0]['locale']}");
                          controller.updateLanguage(
                              controller.localHindi[0]['locale']);
                          AppPreference().updateLang('Hindi');

                          },
                        child: Container(
                          width: width * 0.25,
                          height: 40,
                          decoration: BoxDecoration(
                            color: controller.hindiOnclick.value
                                ? AppTheme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.hindiOnclick.value
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Hindi".tr,
                              style: TextStyle(
                                color: controller.hindiOnclick.value
                                    ? Colors.black
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                      child: Text("Version".tr + ApiUrl.appVersion,
                          style: const TextStyle(
                              fontSize: 18,
                              color: AppTheme.primaryColor,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// void onTap(context){
//   String? countryName;
//   showCountryPicker(
//     context: context,
//
//     showPhoneCode: true,
//     onSelect: (Country country) {
//       debugPrint('Select country: ${country.displayName}');
//         countryName = country.displayName;
//
//     },
//     countryListTheme: CountryListThemeData(
//       textStyle: TextStyle(
//           color: Colors.black
//       ),
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(40.0),
//         topRight: Radius.circular(40.0),
//       ),
//       inputDecoration: InputDecoration(
//         labelText: 'Search',
//         hintText: 'Start typing to search',
//         prefixIcon: const Icon(Icons.search),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: const Color(0xFF8C98A8).withOpacity(0.2),
//           ),
//         ),
//       ),
//       searchTextStyle: const TextStyle(
//         color: Colors.black,
//         fontSize: 18,
//       ),
//     ),
//   );
//
//
//
// }
}

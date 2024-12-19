import 'package:astromaagic/Routes/app_routes.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Components/DateRangeExample.dart';
import '../../Components/OTPInput.dart';
import '../../Components/forms.dart';
import '../../Components/image_pickers.dart';
import '../../Components/theme.dart';
import '../../Controller/LoginController/RegisterScreenController.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  const RegisterScreen({super.key});

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        // selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.marriageController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterScreenController controller = Get.put(RegisterScreenController());
    return Scaffold(
      backgroundColor: AppTheme.screenBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.App_color,
        leading: IconButton(
            icon: const ImageIcon(AssetImage(
              "assets/icons/back_ios.png",
            )),
            color: AppTheme.primaryColor,
            iconSize: 18,
            onPressed: () {
              Get.back();
            }),
        title: Text(
          "Register".tr,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "assets/images/backgrountwo.png",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          "Let\'s get your personalized astro".tr,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontFamily: 'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'account'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: width * 0.2,
                        height: 32,
                        color: AppTheme.primaryColor,
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'set up'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'quickly and'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "easily!".tr,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                    ],
                  ),  Center(
                      child: Stack(children: [
                        Obx(
                              () => Container(
                            width: 120,
                            height: 120,
                            child: controller.itemImage.value != null
                                ? CircleAvatar(
                              backgroundImage: Image.file(
                                controller.itemImage.value?.imagePath,
                                fit: BoxFit.cover,
                              ).image,
                            )
                                : controller.imageString.value != null &&
                                controller.imageString.value.isNotEmpty
                                ? CircleAvatar(
                              backgroundImage:
                              NetworkImage(controller.imageString.value),
                            )
                                : const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://autorevog.blob.core.windows.net/autorevog/uploads/images/18942381.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -25,
                          bottom: 5,
                          child: MaterialButton(
                              color: AppTheme.primaryColor,
                              shape: const CircleBorder(),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImagePicks(
                                          previewImageList: [],
                                          isMultiple: true,
                                          title: "Select Image",
                                          onClose: () => Get.back(),
                                          onSave: (List<PickedImage> images) {
                                            if (images.isNotEmpty) {
                                              controller.itemImage.value =
                                                  images.first;
                                            }
                                            Get.back();
                                          },
                                        )));
                              },
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              )),
                        ),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.fullNameController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            hintText: 'Full Name'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.white),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(Icons.person)),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        onTap: () {
                          DateTime now = DateTime.now();
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 250,
                                  child: CupertinoDatePicker(
                                    onDateTimeChanged: (DateTime newTime) {
                                      String date =
                                          "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                      controller.dateOfBirthController.text =
                                          date;
                                    },
                                    minimumDate: DateTime(
                                        now.year - 104, now.month, now.day),
                                    maximumDate: DateTime.now(),
                                    initialDateTime: DateTime(2001, 5, 5),
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                );
                              });
                        },
                        readOnly: true,
                        controller: controller.dateOfBirthController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            hintText: 'Date of Birth'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.white),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(Icons.calendar_month)),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.areaController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            hintText: 'Area'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.white),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(Icons.location_on_rounded)),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.cityController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            hintText: 'City'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.white),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(Icons.location_on_rounded)),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.stateController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppTheme.white),
                            ),
                            hintText: 'State'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.white),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(Icons.location_on_rounded)),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          onTap: () {
                            showBottomTimePicker(
                                context, controller.timeOfBirthController);
                          },
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          controller: controller.timeOfBirthController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppTheme.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppTheme.white),
                              ),
                              hintText: 'Time of Birth'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              contentPadding: const EdgeInsets.all(6),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.white),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              prefixIcon:
                                  Icon(Icons.access_time_filled_outlined)),
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationThickness: 0,
                              color: AppTheme.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Obx(()=> TextFormField(
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.oldPass.value,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppTheme.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppTheme.white),
                          ),
                          hintText: 'Password'.tr,
                          hintStyle: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.all(6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.white),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon:
                          InkWell(
                            onTap: () {

                              controller.oldPass.value = !controller.oldPass.value;

                            },
                            child: Icon(
                              controller.oldPass.value ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                          ),),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0,
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.working.value =
                                    !controller.working.value;
                                controller.business.value = false;
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: controller.working.value
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.working.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Working".tr,
                                    style: TextStyle(
                                      color: controller.working.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.business.value =
                                    !controller.business.value;
                                controller.working.value = false;
                                ;
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: controller.business.value
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.business.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Business".tr,
                                    style: TextStyle(
                                      color: controller.business.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.married.value =
                                    !controller.married.value;
                                controller.unMarried.value = false;
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: controller.married.value
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.married.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Married".tr,
                                    style: TextStyle(
                                      color: controller.married.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.unMarried.value =
                                    !controller.unMarried.value;
                                controller.married.value = false;
                                ;
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: controller.unMarried.value
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.unMarried.value
                                        ? AppTheme.primaryColor
                                        : Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Unmarried".tr,
                                    style: TextStyle(
                                      color: controller.unMarried.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => controller.married.value == true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                onTap: () {
                                  DateTime now = DateTime.now();
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 250,
                                          child: CupertinoDatePicker(
                                            onDateTimeChanged:
                                                (DateTime newTime) {
                                              String date =
                                                  "${newTime.year}-${newTime.month.toString().length <= 1 ? "0${newTime.month}" : newTime.month.toString()}-${newTime.day.toString().length <= 1 ? "0${newTime.day}" : newTime.day.toString()}";
                                              controller.marriageController
                                                  .text = date;
                                            },
                                            minimumDate: DateTime(
                                                now.year - 104,
                                                now.month,
                                                now.day),
                                            maximumDate: DateTime.now(),
                                            initialDateTime:
                                                DateTime(2001, 5, 5),
                                            use24hFormat: true,
                                            mode: CupertinoDatePickerMode.date,
                                          ),
                                        );
                                      });
                                },
                                readOnly: true,
                                controller: controller.marriageController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: AppTheme.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: AppTheme.white),
                                    ),
                                    hintText: 'Marriage  Date'.tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.all(6),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppTheme.white),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    prefixIcon: Icon(Icons.calendar_month)),
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationThickness: 0,
                                    color: AppTheme.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: height * 0.10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Button(
                            widthFactor: 0.85,
                            heightFactor: 0.06,
                            onPressed: () {
                              // Get.toNamed(AppRoutes.login.toName);
                              if (controller.isUploading.value) {
                                return;
                              }
                              controller.loginCall(context);
                              // if (controller.married.value == true ||
                              //     controller.unMarried.value == true) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               RegisterScreen()));
                              // } else {
                              //   Fluttertoast.showToast(
                              //     msg: "Please Select Marriage Status!!",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.black,
                              //     textColor: Colors.white,
                              //   );
                              // }
                            },
                            child: Text("Submit".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showBottomTimePicker(
    BuildContext context,
    TextEditingController controller,
  ) {
    var times;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: 280,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 20, width: 20),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text("Select Time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppTheme.appBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                  ),
                  Expanded(
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      spacing: 30,
                      itemHeight: 37,
                      itemWidth: 60,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        times = time;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton2(
                        width: width * 0.45,
                        height: 40,
                        title: 'Cancel',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Get.back();
                        },
                        color: Colors.white,
                        titleColor: AppTheme.bottomTabsLabelInActiveColor,
                        borderColor: AppTheme.cancelBorder,
                      ),
                      AppButton2(
                        width: width * 0.45,
                        height: 40,
                        title: 'Save ',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onPressed: () {
                          controller.text = " ${formatDate(times, [
                                hh.trim(),
                                ':',
                                nn.trim(),
                                ':',
                                am.trim()
                              ])}";
                          Navigator.of(context).pop();
                        },
                        titleColor: Colors.black,
                        color: AppTheme.primaryColor,
                        borderColor: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

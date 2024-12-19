import 'package:astromaagic/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Components/forms.dart';
import '../../Components/theme.dart';
import '../../Controller/LoginController/ForgotPasswordController.dart';
import '../../Provider/MenuDataProvider.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  const ForgotPassword({super.key});


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ForgotPasswordController controller = Get.put(ForgotPasswordController());
    controller. userDataProvider =
        Provider.of<MenuDataProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async{
        Get.offAllNamed(AppRoutes.Login.toName);

        return true;
      },
      child: Scaffold(
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
                Get.offAllNamed(AppRoutes.Login.toName);
              }),
        ),
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
                      "forgot password".tr,
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
                    decoration: BoxDecoration(
                        color: AppTheme.screenBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Obx(()=> TextFormField(
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.oldPass.value,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                        ),
                        hintText: "Enter your mobile password".tr,
                        hintStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        contentPadding: const EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
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
                          color: AppTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),)
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.screenBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Obx(()=> TextFormField(
                      controller: controller.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.newPass.value,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                        ),
                        hintText: "Enter your confirm password".tr,
                        hintStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon:
                        InkWell(
                          onTap: () {

                            controller.newPass.value = !controller.newPass.value;

                          },
                          child: Icon(
                              controller.newPass.value ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
                        ),
                      ),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                          color: AppTheme.containerBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),)
                  ),

                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    child: Obx(() =>  Button(
                        widthFactor: 0.91,
                        heightFactor: 0.06,
                        onPressed: () {
                          if(controller.isLoading.value){
                            return;
                          }
                          controller.loginCall(context);
                        },
                        child:
                        controller.isLoading.value
                            ? Container(
                            height: height * 0.04,
                            width: height * 0.04,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ))
                            :

                        Text("Re-Set".tr,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ))),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

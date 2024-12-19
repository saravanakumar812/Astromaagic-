import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../Components/theme.dart';
import '../../Controller/Settings/SupportScreenController.dart';
import '../../Utils/BottomNavBarScreen.dart';
import 'Setting.dart';

class SupportScreen extends GetView<SupportScreenController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppTheme.screenBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.App_color,
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
                  (route) => false,
            );
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          'Support'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      // body: WebViewWidget(
      //   controller: controller.controller,
      // ),
    ));
  }
}

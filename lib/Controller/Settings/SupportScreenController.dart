import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';



class SupportScreenController extends GetxController {
  late final WebViewController controller;
  @override
  void onInit() {
    super.onInit();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://astromaagic.com/privacy-policy/'),
      );
  }

}

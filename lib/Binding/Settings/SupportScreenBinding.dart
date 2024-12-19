import 'package:get/get.dart';

import '../../Controller/Settings/SettingController.dart';
import '../../Controller/Settings/SupportScreenController.dart';
class SupportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportScreenController>(() => SupportScreenController());
  }
}

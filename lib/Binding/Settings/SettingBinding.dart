import 'package:get/get.dart';

import '../../Controller/Settings/SettingController.dart';
class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}

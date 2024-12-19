import 'package:get/get.dart';

import '../../Controller/Settings/FAQScreenController.dart';
import '../../Controller/Settings/SettingController.dart';
class FAQSCreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQScreenController>(() => FAQScreenController());
  }
}

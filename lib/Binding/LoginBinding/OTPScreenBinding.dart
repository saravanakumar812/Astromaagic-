import 'package:get/get.dart';
import '../../Controller/LoginController/OTPScreenController.dart';

class OTPScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPScreenController>(() => OTPScreenController());
  }
}

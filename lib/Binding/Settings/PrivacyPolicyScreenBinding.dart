import 'package:get/get.dart';
import '../../Controller/LoginController/ForgotPasswordController.dart';
import '../../Controller/Settings/PrivacyPolicyScreenController.dart';

class PrivacyPolicyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyScreenScreenController>(() => PrivacyPolicyScreenScreenController());
  }
}

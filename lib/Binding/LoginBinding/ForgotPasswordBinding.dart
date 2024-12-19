import 'package:get/get.dart';
import '../../Controller/LoginController/ForgotPasswordController.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

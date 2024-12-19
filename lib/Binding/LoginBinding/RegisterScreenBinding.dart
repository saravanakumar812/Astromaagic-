import 'package:astromaagic/Controller/LoginController/RegisterScreenController.dart';
import 'package:get/get.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}

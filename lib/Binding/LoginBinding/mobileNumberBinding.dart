import 'package:get/get.dart';
import '../../Controller/LoginController/mobileNumberScreenController.dart';

class mobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<mobileNumberScreenController>(() => mobileNumberScreenController());
  }
}

import 'package:get/get.dart';
import '../../Controller/SplashController/SplashScreenController.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}

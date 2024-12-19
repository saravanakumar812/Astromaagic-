import 'package:get/get.dart';
import '../../Controller/HomeController/HomeScreenController.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}

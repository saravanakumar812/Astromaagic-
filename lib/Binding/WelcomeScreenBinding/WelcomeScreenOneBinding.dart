import 'package:get/get.dart';
import '../../Controller/WelcomeScreenController/WelcomeScreenOneController.dart';

class WelcomeScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeScreenOneController>(() => WelcomeScreenOneController());
  }
}

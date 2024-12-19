import 'package:get/get.dart';
import '../../Controller/WelcomeScreenController/WelcomeScreenTwoControlller.dart';

class WelcomeScreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeScreenTwoController>(() => WelcomeScreenTwoController());
  }
}

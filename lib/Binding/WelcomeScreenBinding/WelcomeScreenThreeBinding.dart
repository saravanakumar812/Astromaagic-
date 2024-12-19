import 'package:get/get.dart';
import '../../Controller/WelcomeScreenController/WelcomeScreenThreeController.dart';

class WelcomeScreenThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeScreenThreeController>(
        () => WelcomeScreenThreeController());
  }
}

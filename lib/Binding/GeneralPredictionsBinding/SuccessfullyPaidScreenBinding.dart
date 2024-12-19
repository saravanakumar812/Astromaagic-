import 'package:get/get.dart';
import '../../Controller/GeneralPredictionsController/SuccessfullyPaidScreenController.dart';

class SuccessfullyPaidScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessfullyPaidScreenController>(
        () => SuccessfullyPaidScreenController());
  }
}

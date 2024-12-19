import 'package:get/get.dart';
import '../../Controller/GeneralPredictionsController/ChoosePaymentScreenController.dart';

class ChoosePaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoosePaymentScreenController>(
        () => ChoosePaymentScreenController());
  }
}

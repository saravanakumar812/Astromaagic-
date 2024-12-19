import 'package:get/get.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenTwoController.dart';
class GeneralPredictionScreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralPredictionScreenTwoController>(() => GeneralPredictionScreenTwoController());
  }
}

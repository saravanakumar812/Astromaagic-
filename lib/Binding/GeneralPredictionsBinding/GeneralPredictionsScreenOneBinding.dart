import 'package:get/get.dart';

import '../../Controller/GeneralPredictionsController/GeneralPredictionScreenOneController.dart';

class GeneralPredictionScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralPredictionScreenOneController>(() => GeneralPredictionScreenOneController());
  }
}

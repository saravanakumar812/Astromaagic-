import 'package:get/get.dart';
import '../../Controller/GeneralPredictionsController/GeneralPredictionVoiceMessageScreenController.dart';


class GeneralPredictionVoiceMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralPredictionVoiceMessageController>(
        () => GeneralPredictionVoiceMessageController());
  }
}

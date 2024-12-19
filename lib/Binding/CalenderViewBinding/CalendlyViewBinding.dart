import 'package:get/get.dart';
import '../../Controller/CalenderViewController/CalendlyViewController.dart';

class CalendlyViewBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CalendlyController>(() => CalendlyController());
  }

}

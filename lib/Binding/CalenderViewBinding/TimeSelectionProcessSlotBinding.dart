import 'package:get/get.dart';
import '../../Controller/CalenderViewController/CalendlyViewController.dart';
import '../../Controller/CalenderViewController/TimeSlotProcessController.dart';


class TimeSelectionSlotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeSelectionSlotController>(() => TimeSelectionSlotController());
  }
}

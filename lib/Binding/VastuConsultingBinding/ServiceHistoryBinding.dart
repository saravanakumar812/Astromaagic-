import 'package:get/get.dart';
import '../../Controller/VastuConsulting/ServiceHistoryController.dart';

class ServiceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceHistoryController>(() => ServiceHistoryController());
  }
}

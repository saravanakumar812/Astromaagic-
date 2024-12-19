import 'package:get/get.dart';
import '../../Controller/VastuConsulting/VastuConsultingController.dart';

class VastuConsultingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VastuConsultingController>(() => VastuConsultingController());
  }
}

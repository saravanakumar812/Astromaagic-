import 'package:get/get.dart';

import '../../Controller/VastuConsulting/VastuConsultingPriceSlotController.dart';

class VastuConsultingPriceSlotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VastuConsultingPriceSlotController>(() => VastuConsultingPriceSlotController());
  }
}

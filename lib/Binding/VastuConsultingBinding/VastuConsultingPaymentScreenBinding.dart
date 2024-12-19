import 'package:get/get.dart';

import '../../Controller/VastuConsulting/VastuConsultingPaymentScreenController.dart';
import '../../Controller/VastuConsulting/VastuConsultingPriceSlotController.dart';

class VastuConsultingPaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VastuConsultingPaymentScreenController>(() => VastuConsultingPaymentScreenController());
  }
}

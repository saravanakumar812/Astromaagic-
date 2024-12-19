import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../Controller/AdminServiceViewConrtroler/AdminServicesListController.dart';

class AdminServicesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminServicesListController>(
        () => AdminServicesListController());
  }
}

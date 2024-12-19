import 'package:get/get.dart';

import '../../Controller/AdminServiceViewConrtroler/AdminServicesViewScreenController.dart';
class AdminServicesViewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminServicesViewScreenController>(
        () => AdminServicesViewScreenController());
  }
}

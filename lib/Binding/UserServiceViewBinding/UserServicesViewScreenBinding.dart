import 'package:get/get.dart';

import '../../Controller/UserServiceViewController/UserServicesViewScreenController.dart';
class UserServicesViewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserServicesViewScreenController>(
        () => UserServicesViewScreenController());
  }
}

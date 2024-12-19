import 'package:get/get.dart';

import '../../Controller/Settings/EditProfileScreenController.dart';

class EditProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileScreenController>(() => EditProfileScreenController());
  }
}

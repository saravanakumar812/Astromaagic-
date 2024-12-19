import 'package:get/get.dart';
import '../../Controller/CountrySelectionController/CountrySelectionController.dart';
import '../../Controller/HomeController/HomeScreenController.dart';

class CountrySelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountrySelectionScreenController>(() => CountrySelectionScreenController());
  }
}

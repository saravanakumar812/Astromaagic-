import 'dart:async';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  RxBool initialLoading = RxBool(false);
  int currentSec = 0;
  late Timer timer;

  @override
  void onInit() async {
    super.onInit();
    initializer();
  }

  void initializer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (currentSec == 6) {
        timer.cancel();
        // Get.offNamed(AppRoutes.login.toName);
      } else {
        currentSec++;
      }
    });
  }
}

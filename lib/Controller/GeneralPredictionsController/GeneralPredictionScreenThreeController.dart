import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';


class GeneralPredictionScreenThreeController extends GetxController {
  final CarouselController controllerOne = CarouselController();
  RxInt currentIndex = RxInt(0);
  RxInt current = RxInt(0);

  void updatePageIndicator(index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  List<String> sliderImage = [
    "assets/images/logo.png",
    "assets/images/BackGround.png",
  ];

}

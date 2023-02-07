import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  RxBool on_Off = false.obs;
  RxBool isRotate = false.obs;
  AnimationController? animationController;
  RxInt milliseconds = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  startAnimation() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animationController!.repeat();
  }

  desposeAnimation() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animationController!.repeat();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController!.dispose();
    super.onClose();
  }
}

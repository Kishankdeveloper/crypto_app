import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {

  final PageController pageController = PageController();
  int currentIndex = 0;
  late Timer timer;

  final List<String> images = [
    'assets/images/vector_one.png',
    'assets/images/vector_two.png',
    'assets/images/coin_image.png',
  ];

  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.onInit();
  }


  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }


}
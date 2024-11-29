import 'package:crypto_app/modules/onboard/onboard_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        builder: (OnboardingController onboardController){
          return Scaffold(
            body: SizedBox(
              height: h,
              width: w,
              child: Stack(
                children: [
                  Positioned(
                    top: h * 0.06,
                    child: Row(
                      children: [
                        Text(' X',
                          style: TextStyle(
                              fontSize: w * 0.17,
                              fontFamily: 'madaBold',
                              color: AppColors.primary
                          ),),
                        Text('-Chain',
                        style: TextStyle(
                          fontSize: w * 0.17,
                          fontFamily: 'madaBold'
                        ),),
                      ],
                    ),
                  ),
                  Positioned(
                    top: h * 0.17,
                      right: 0,
                      left: 0,
                      child: /*Image.asset(
                          'assets/images/oboard_asset.png',
                        fit: BoxFit.cover,
                        width: w * 0.9,
                        height: w * 0.9,
                      )*/
                    sliderWidget(h, w)
                  ),
                  Positioned(
                    top: h * 0.65,
                      left: w * 0.05,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Be a part of the advanced\ngrowing digital systems',
                            style: TextStyle(
                                fontSize: w * 0.07,
                                fontFamily: 'madaBold'
                            ),),
                          SizedBox(
                            height: h * 0.03,
                          ),
                          Text('Connect with new people on our advanced features\nplatform and collect free rewards and enjoy holding.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: w * 0.035,
                                fontFamily: 'madaBold'
                            ),),
                        ],
                      )),
                  Positioned(
                    bottom: h * 0.03,
                      left: w * 0.03,
                      right: w * 0.03,
                      child: buttonWidget(h, w))
                ],
              ),
            ),
          );
        });
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          Get.toNamed(Routes.login);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w * 0.04)
          ),
          minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Get Started',
        style: TextStyle(
          color: Colors.white,
          fontSize: w * 0.05,
          fontFamily: 'madaSemiBold'
        ),));
  }

  Widget sliderWidget(var h, var w) {
    return SizedBox(
      height: h * 0.9,
      width: w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: h * 0.35,
            width: w,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.images.length,
              onPageChanged: (index) {
                controller.currentIndex = index;
                controller.update();
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  controller.images[index],
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          SizedBox(height: h * 0.05),
          SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.images.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: w * 0.05,
              activeDotColor: AppColors.primary,
              dotColor: AppColors.white100,
            ),
          ),
        ],
      ),
    );
  }
  
}
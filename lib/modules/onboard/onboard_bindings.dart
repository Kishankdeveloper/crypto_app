import 'package:crypto_app/modules/onboard/onboard_controller.dart';
import 'package:get/get.dart';

class OnboardingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(()=> OnboardingController());
  }

}
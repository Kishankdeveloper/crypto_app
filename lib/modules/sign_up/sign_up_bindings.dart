import 'package:crypto_app/modules/sign_up/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUPBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }

}
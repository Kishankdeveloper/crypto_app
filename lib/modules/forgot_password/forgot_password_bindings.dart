import 'package:crypto_app/modules/forgot_password/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(()=> ForgotPasswordController());
  }

}
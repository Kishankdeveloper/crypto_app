import 'package:crypto_app/modules/otp_auth/otp_auth_controller.dart';
import 'package:get/get.dart';

class OtpAuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpAuthController>(()=> OtpAuthController());
  }

}
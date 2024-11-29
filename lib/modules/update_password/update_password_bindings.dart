import 'package:crypto_app/modules/update_password/update_password_controller.dart';
import 'package:get/get.dart';

class UpdatePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(() => UpdatePasswordController());
  }

}
import 'package:crypto_app/modules/terms_policy/terms_policy_controller.dart';
import 'package:get/get.dart';

class TermsPolicyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsPolicyController>(()=> TermsPolicyController());
  }

}
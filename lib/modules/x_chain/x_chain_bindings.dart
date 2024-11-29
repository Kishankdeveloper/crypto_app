import 'package:crypto_app/modules/x_chain/x_chain_controller.dart';
import 'package:get/get.dart';

class XChainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XChainController>(() => XChainController());
  }

}
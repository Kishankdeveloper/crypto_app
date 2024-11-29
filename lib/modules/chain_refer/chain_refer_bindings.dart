import 'package:crypto_app/modules/chain_refer/chain_refer_controller.dart';
import 'package:get/get.dart';

class ChainReferBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChainReferController>(() => ChainReferController());
  }

}
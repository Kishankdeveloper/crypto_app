import 'package:crypto_app/modules/wallet/wallet_controller.dart';
import 'package:get/get.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
  }

}
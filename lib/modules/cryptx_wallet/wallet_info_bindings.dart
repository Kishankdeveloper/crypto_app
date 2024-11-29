import 'package:crypto_app/modules/cryptx_wallet/wallet_info_controller.dart';
import 'package:get/get.dart';

class WalletInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletInfoController>(() => WalletInfoController());
  }

}
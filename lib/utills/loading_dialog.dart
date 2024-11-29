import 'package:crypto_app/utills/widget_utils.dart';
import 'package:get/get.dart';

typedef CloseDialog = void Function();

abstract class LoadingDialog {
  static CloseDialog? _loadingDialog;

  static CloseDialog _showLoadingDialog() {
    Get.printInfo(info: 'initialized loading');
    WidgetUtils.loadingDialog();
    return WidgetUtils.closeDialog;
  }

  static void showLoadingDialog() {
    _loadingDialog = _showLoadingDialog();
    Get.printInfo(info: 'start loading');
  }

  static void closeLoadingDialog() {
    Get.printInfo(info: 'close loading');
    _loadingDialog?.call();
  }
}

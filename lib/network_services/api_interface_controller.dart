import 'dart:ui';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'api_error.dart';

class ApiInterfaceController extends GetxController {
  ApiError? error;

  VoidCallback? retry;

  void onRetryTap() {
    error = null;
    retry?.call();
    update();
  }
}
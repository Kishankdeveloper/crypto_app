import 'package:crypto_app/modules/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(()=> DashboardController());
  }

}
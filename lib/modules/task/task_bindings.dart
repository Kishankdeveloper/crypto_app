import 'package:crypto_app/modules/task/task_controller.dart';
import 'package:get/get.dart';

class TaskBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }

}
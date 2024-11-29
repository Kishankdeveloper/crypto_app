import 'dart:convert';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/start_mining_model.dart';
import 'package:crypto_app/network_services/models/tasks_list_model.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utills/dprint.dart';

class TaskController extends GetxController with WidgetsBindingObserver{

  final ApiHelper _apiHelper = ApiHelper.to;
  RxBool loading = false.obs;
  List<TaskListData>? taskList;
  String taskId = "";
  RxString taskAmount = "".obs;
  String linkURL = "";

  @override
  void onInit() {
    Future.microtask(() {
      getTasks();
      WidgetsBinding.instance.addObserver(this);  // Add the observer
    });
    super.onInit();
  }

  Future<void> getTasks() async {
    loading.value = true;

    var payload = {
      "user_id" : "${Storage.getValue(Constants.userId)}"
    };
    taskList?.clear();
    dprint(payload);
      _apiHelper.getTasks(jsonEncode(payload)).futureValue((v){
        var res = TasksListModel.fromJson(jsonDecode(v));
        if(res.status ?? false) {
          taskList = res.data ?? [];
        } else {
          //WidgetUtils.showSnackbar(res.message ?? 'Something went wrong');
        }
        loading.value = false;
      }, retryFunction: getTasks);
  }

  Future<void> startTask() async {
    loading.value = true;
    var payload = {
      "user_id" : "${Storage.getValue(Constants.userId)}",
      "task_id" : taskId
    };
    _apiHelper.startTasks(jsonEncode(payload)).futureValue((v) {
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if(res.status ?? false){
        WidgetUtils.launch(linkURL);
      }
    }, retryFunction: startTask);
    loading.value = false;
  }

  Future<void> claimTask() async {
    loading.value = true;
    var payload = {
      "user_id" : "${Storage.getValue(Constants.userId)}",
      "task_id" : taskId
    };
    _apiHelper.claimTasks(jsonEncode(payload)).futureValue((v) {
      var res = StartMiningModel.fromJson(jsonDecode(v));
      WidgetUtils.showAlertDialogue(Get.context!, "Congratulation you got ${taskAmount.value} x-coin");
      if(res.status ?? false){
        getTasks();
        //WidgetUtils.showSnackbar(res.message ?? "");
      }
    }, retryFunction: startTask);
    loading.value = false;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);  // Remove observer when done
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App is back to the foreground, refresh the tasks
      getTasks();
    }
  }

}
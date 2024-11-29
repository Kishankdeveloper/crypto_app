import 'dart:convert';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/update_pass_model.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utills/dprint.dart';
import '../login/login_controller.dart';

class UpdatePasswordController extends GetxController {

  final previousPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String type = '';
  final formKey = GlobalKey<FormState>();
  final ApiHelper _apiHelper = ApiHelper.to;

  @override
  void onInit() {
    type = Get.arguments['type'];
    super.onInit();
  }
  Future<void> updatePass() async {

    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString(),
      "new_password" : newPasswordController.text,
      "confirm_password" : confirmPasswordController.text
    };

    if(formKey.currentState!.validate()) {
      _apiHelper.updatePass(jsonEncode(payload)).futureValue((v){
        var res = UpdatePassModel.fromJson(jsonDecode(v));
        dprint("${res.message}");
        if(res.status ?? false) {
          if(type == 'forgot'){
            WidgetUtils.showSuccess(res.message ?? "password updated successfully");
            Get.offNamedUntil(Routes.login, (routes) => false);
            Get.put(LoginController());
          } else {
            Get.back();
          }
        } else {
          dprint("${res.message}");
          WidgetUtils.showSnackbar(res.message ?? "something went wrong");
        }
      }, retryFunction: updatePass);
    }
  }
  
}
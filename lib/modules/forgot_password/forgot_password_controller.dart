import 'dart:convert';

import 'package:crypto_app/modules/login/login_controller.dart';
import 'package:crypto_app/modules/otp_auth/otp_auth_controller.dart';
import 'package:crypto_app/modules/sign_up/sign_up_controller.dart';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/forgot_pass_model.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  final phoneController = TextEditingController();

  final ApiHelper _apiHelper = ApiHelper.to;

  Future<void> authenticatePhone() async {
    var payload = {
      "mobile_no" : phoneController.text
    };

    _apiHelper.forgotPass(jsonEncode(payload)).futureValue((v) {
      var res = ForgotPassModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        Storage.saveValue(Constants.userId, res.data?.userId.toString());
        Get.toNamed(Routes.otp, arguments: {
          "phone" : phoneController.text,
          "type" : "forgotPassword"
        });
      } else {
        WidgetUtils.showSnackbar(res.message ?? "Something went wrong");
      }
    }, retryFunction: authenticatePhone);
  }

}
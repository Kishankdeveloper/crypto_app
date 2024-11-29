import 'dart:convert';

import 'package:crypto_app/modules/otp_auth/otp_auth_controller.dart';
import 'package:crypto_app/modules/sign_up/sign_up_controller.dart';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/login_model.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool termsCheck = false.obs;
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final ApiHelper _apiHelper = ApiHelper.to;

  Future<void> loginUser() async  {
    var payload = {
      "mobile_or_email" : userIdController.text,
      "password" : passwordController.text
    };

    if(loginFormKey.currentState!.validate()){

      _apiHelper.login(jsonEncode(payload)).futureValue((v){
        var res = LoginModel.fromJson(jsonDecode(v));
        if(res.status ??  false) {
          userIdController.clear();
        passwordController.clear();
          Storage.clearStorage();
          Storage.saveValue(Constants.userId, res.data?.id.toString());
          Storage.saveValue(Constants.userName, res.data?.name.toString());
          Storage.saveValue(Constants.mobile, res.data?.mobileNo.toString());
          Storage.saveValue(Constants.email, res.data?.email.toString());
          Storage.saveValue(Constants.xbtBalance, res.data?.xbtBalance.toString());
          Storage.saveValue(Constants.xbtCoinBalance, res.data?.xcoinBalance.toString()).then((v) => {
            Get.offNamedUntil(Routes.dashboard, (routes) => false),
          });
        } else {
          WidgetUtils.showSnackbar(res.message ??  "something went wrong");
        }
      }, retryFunction: loginUser);
    }

  }
  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
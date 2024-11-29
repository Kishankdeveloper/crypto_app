import 'dart:async';
import 'dart:convert';

import 'package:crypto_app/modules/login/login_controller.dart';
import 'package:crypto_app/modules/sign_up/sign_up_controller.dart';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/otp_model.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utills/app_pages.dart';

class OtpAuthController extends GetxController {
  RxString otpVal = ''.obs;
  var seconds = 60.obs;
  late Timer _timer;
  RxBool showResend = false.obs;
  RxBool showTimer = false.obs;
  String phoneNumber = '';
  bool loading = false;
  String type = '';

  final ApiHelper _apiHelper = ApiHelper.to;

  @override
  void onInit() {
   // phoneNumber = Get.arguments;
    phoneNumber = Get.arguments["phone"];
    type = Get.arguments["type"];
    debugPrint('onInitCalled==============>');
    startTimer();
    super.onInit();
  }

  void startTimer() {
    debugPrint('timer---function called------->$seconds');
    //  _timer.cancel();
    seconds.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
        showResend.value = false;
        showTimer.value = true;
        debugPrint('timer---------->$seconds');
      } else {
        _timer.cancel();
        showResend.value = true;
        showTimer.value = false;
      }
    });
  }

  Future<void> verifyUser() async {
    var payload = {
      'user_id' : "${Storage.getValue(Constants.userId)}",
      "otp" : otpVal.value,
      "otp_type" : type ==  'register' ? 'registration' : 'forgot_password'
    };
    if(otpVal.value == 'null' || otpVal.value.isEmpty) {
      WidgetUtils.showSnackbar('Please enter valid otp');
    }else{
      _apiHelper.verifyOtp(jsonEncode(payload)).futureValue((v) {
        var res = OtpModel.fromJson(jsonDecode(v));
        if(res.status ?? false) {
          if(type ==  'register') {
            Get.offAllNamed(Routes.login);
          } else {
            Get.toNamed(Routes.updatePassword, arguments: {
              "type" : "forgot"
            });
          }
        } else {
          WidgetUtils.showSnackbar(res.message ?? 'Something went wrong');
        }
      }, retryFunction: verifyUser);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
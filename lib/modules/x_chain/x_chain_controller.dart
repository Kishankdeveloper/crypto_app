import 'dart:convert';

import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../network_services/models/home_model.dart';
import '../../network_services/models/start_mining_model.dart';
import '../../utills/constants.dart';
import '../../utills/storage.dart';
import '../../utills/widget_utils.dart';

class XChainController extends GetxController {

  final usdtController = TextEditingController();
  final xbtController = TextEditingController();
  final ApiHelper _apiHelper = ApiHelper.to;
  HomeData? homeData;
  RxBool loading = false.obs;

  @override
  void onInit() {
    Future.microtask(() => {
      homeDashboard()
    });
    super.onInit();
  }

  Future<void> homeDashboard() async {
    loading.value = true;
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString()
    };

    _apiHelper.homeDashboard(jsonEncode(payload)).futureValue((v) {
      var res = HomeModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        homeData = res.data ?? HomeData();

        // clear storage data
        if(Storage.hasData(Constants.xbtBalance)){
          Storage.removeValue(Constants.xbtBalance);
        }
        if(Storage.hasData(Constants.xbtCoinBalance)){
          Storage.removeValue(Constants.xbtCoinBalance);
        }
        if(Storage.hasData(Constants.usdtBalance)){
          Storage.removeValue(Constants.usdtBalance);
        }

        //save storage data in local
        Storage.saveValue(Constants.xbtBalance, res.data!.xbtBalance.toString());
        Storage.saveValue(Constants.xbtCoinBalance, res.data!.xcoinBalance.toString());
        Storage.saveValue(Constants.usdtBalance, res.data!.usdtBalance.toString());
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: homeDashboard);
  }

  Future<void> swap() async {
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString(),
      "usdt_amount" : usdtController.text
    };

    if(usdtController.text.isEmpty){
      return WidgetUtils.showSnackbar('Please enter USDT amount');
    }

    _apiHelper.swap(jsonEncode(payload)).futureValue((v){
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if(res.status ?? false) {
        WidgetUtils.showAlertDialogue(Get.context!, res.message ?? "Something went wrong");
        homeDashboard();
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "Something went wrong");
      }
    }, retryFunction: swap);
  }

  RxInt xbtValue() {
    int conversion = int.parse(usdtController.text) * 18;
    return conversion.obs;
  }
}
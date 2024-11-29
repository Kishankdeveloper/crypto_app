import 'dart:convert';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:get/get.dart';
import '../../network_services/models/home_model.dart';
import '../../utills/constants.dart';
import '../../utills/storage.dart';

class WalletController extends GetxController {
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
      //  WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: homeDashboard);
  }

}
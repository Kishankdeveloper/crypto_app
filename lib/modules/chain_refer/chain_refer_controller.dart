import 'dart:convert';
import 'package:crypto_app/network_services/models/refer_list_model.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/dprint.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:get/get.dart';
import '../../network_services/api_helper.dart';
import '../../network_services/models/home_model.dart';

class ChainReferController extends GetxController {

  final ApiHelper _apiHelper = ApiHelper.to;
  RxBool loading = false.obs;
  List<ReferList>? referList;
  HomeData? homeData;
  String referralCode = "";
  @override
  void onInit() {
    Future.microtask(() {
      homeDashboard();
    });
    super.onInit();
  }

  Future<void> getReferList() async  {
    loading.value = true;

    var payload = {
      "user_id" : "${Storage.getValue(Constants.userId)}"
    };
    dprint(payload);
    _apiHelper.referList(jsonEncode(payload)).futureValue((v) {
      var res = ReferListModel.fromJson(jsonDecode(v));
      if(res.status ??  false) {
        referList = res.data ?? [];
      } else {
      //  WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
      update();
    }, retryFunction: getReferList);
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
        referralCode = res.data?.refferalCode ?? '';
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
        Storage.saveValue(Constants.referCode, res.data!.refferalCode.toString());
        getReferList();
        update();
      } else  {
       // WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: homeDashboard);
  }
}
import 'package:crypto_app/modules/chain_refer/chain_refer_screen.dart';
import 'package:crypto_app/modules/home/home_screen.dart';
import 'package:crypto_app/modules/task/task_screen.dart';
import 'package:crypto_app/modules/wallet/wallet_screen.dart';
import 'package:crypto_app/modules/x_chain/x_chain_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  RxInt selectedIndex = 0.obs;

  List<Widget> buildScreens  = <Widget>[
      const HomeScreen(),
      const TaskScreen(),
      const XChainScreen(),
      const ChainReferScreen(),
      const WalletScreen()
    ];

  void onItemTapped(int index){
    selectedIndex.value = index;
    //  update();
  }

}
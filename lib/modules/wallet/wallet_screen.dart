import 'package:crypto_app/modules/wallet/wallet_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: WalletController(),
        builder: (WalletController walletController) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: (){},
                  icon: const SizedBox.shrink()
              ),
              centerTitle: true,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: w * 0.13,),
                  Image.asset('assets/images/x-coin.png', width: w * 0.11,),
                  SizedBox(width: w * 0.02,),
                  Text('X-Chain',
                  style: TextStyle(
                    fontSize: w * 0.06,
                    fontFamily: 'madaBold'
                  ),),
                ],
              ),
           /*   actions: [
                Text('\$ 0.00',
                  style: TextStyle(
                      fontSize: w * 0.05,
                      fontFamily: 'madaSemiBold'
                  ),),
                SizedBox(width: w * 0.03,),
              ],*/
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                controller.homeDashboard();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: ListView(
                  children: [
                    SizedBox(
                      height: h * 0.02,
                    ),
                    headerWidget(h, w),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    usdtWidget(h, w),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    xCoinWidget(h, w),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    xbtCoinWidget(h, w),
                    // referralBonus(h, w),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    //farmMoney(h, w)
                  ],
                ),),
            ),
          );
        });
  }

  Widget headerWidget(var h, var w) {
    return Container(
      width: w,
      height: h * 0.13,
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.02),
        color: AppColors.white100
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Total portfolio value',
              style: TextStyle(
                color: AppColors.white60,
                fontFamily: 'madaRegular',
                fontSize: w * 0.035
              ),),
              IconButton(
                  onPressed: (){},
                  padding: EdgeInsets.zero,
                  splashRadius: 0.2,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.info_outline_rounded, size: w * 0.045,color: AppColors.white70,))
            ],
          ),
          Obx(() => controller.loading.value ?
          Text('\$ 00.00',
            style: TextStyle(
                fontFamily: 'madaBold',
                fontSize: w * 0.07
            ),) :
          Text('\$ ${(double.parse(Storage.getValue(Constants.xbtBalance) ?? '0.00') / 18) + double.parse(Storage.getValue(Constants.usdtBalance) ?? "0.00")}',
            style: TextStyle(
                fontFamily: 'madaBold',
                fontSize: w * 0.07
            ),)),
          /*Row(
            children: [
              Text('Crypto holdings',
                style: TextStyle(
                    color: AppColors.white60,
                    fontFamily: 'madaRegular',
                    fontSize: w * 0.03
                ),),
              IconButton(
                  onPressed: (){},
                  padding: EdgeInsets.zero,
                  splashRadius: 0.01,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.info_outline_rounded, size: w * 0.04,color: AppColors.white70,)),
            ],
          ),
          Row(
            children: [
              Text('\$ 25,868.99',
                style: TextStyle(
                    fontFamily: 'madaSemiBold',
                    fontSize: w * 0.04
                ),),
              SizedBox(width: w * 0.05,),
              Text('+ 0.2%',
                softWrap: true,
                style: TextStyle(
                    color: AppColors.success40,
                    fontFamily: 'madaBold',
                    fontSize: w * 0.04
                ),),
            ],
          ),*/
        ],
      ),
    );
  }
  
  Widget usdtWidget(var h, var w){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.walletInfo, arguments: "USDT");
      },
      child: Container(
        width: w,
        height: h * 0.13,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.02),
            color: AppColors.white100
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/images/usdt_icon.png', width: w * 0.17, fit: BoxFit.cover,),
                SizedBox(width: w * 0.05,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('USDT',
                      style: TextStyle(
                          fontSize: w * 0.06,
                          fontFamily: 'madaBold'
                      ),),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text('Doller',
                      style: TextStyle(
                          color: AppColors.white70,
                          fontSize: w * 0.035,
                          fontFamily: 'madaSemiBold'
                      ),),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => controller.loading.value ?
                Text('\$ 0.00 USD',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),) :
                Text('\$ ${Storage.getValue(Constants.usdtBalance)} USD',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),)),
                SizedBox(
                  height: h * 0.01,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    decoration: BoxDecoration(
                      color: AppColors.success40,
                      borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('+ Deposit',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.035
                    ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget xCoinWidget(var h, var w){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.walletInfo, arguments: "X-Coin");
      },
      child: Container(
        width: w,
        height: h * 0.13,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.02),
            color: AppColors.white100
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/images/x-coin.png', width: w * 0.158, height: h * 0.1, fit: BoxFit.cover,),
                SizedBox(width: w * 0.05,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('X-Coin',
                      style: TextStyle(
                          fontSize: w * 0.06,
                          fontFamily: 'madaBold'
                      ),),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text('X Coin',
                      style: TextStyle(
                          color: AppColors.white70,
                          fontSize: w * 0.035,
                          fontFamily: 'madaSemiBold'
                      ),),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => controller.loading.value ?
                Text('\$ 0.00 X-Coin',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),) :
                Text('${Storage.getValue(Constants.xbtCoinBalance)} X-Coin',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),)),
                SizedBox(
                  height: h * 0.01,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    decoration: BoxDecoration(
                        color: AppColors.success40,
                        borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('+ Deposit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.035
                      ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget xbtCoinWidget(var h, var w){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.walletInfo, arguments: "XBT");
      },
      child: Container(
        width: w,
        height: h * 0.13,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.02),
            color: AppColors.white100
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/images/x-coin.png', width: w * 0.158, height: h * 0.1, fit: BoxFit.cover,),
                SizedBox(width: w * 0.05,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('XBT-Coin',
                      style: TextStyle(
                          fontSize: w * 0.06,
                          fontFamily: 'madaBold'
                      ),),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text('XBT Coin',
                      style: TextStyle(
                          color: AppColors.white70,
                          fontSize: w * 0.035,
                          fontFamily: 'madaSemiBold'
                      ),),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => controller.loading.value ?
                Text('0.00 XBT-Coin',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),) :
                Text('${Storage.getValue(Constants.xbtBalance)} XBT-Coin',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaBold'
                  ),)),
                SizedBox(
                  height: h * 0.01,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    decoration: BoxDecoration(
                        color: AppColors.success40,
                        borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('+ Deposit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.035
                      ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  Widget referralBonus(var h, var w) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.walletInfo);
      },
      child: Container(
        width: w,
        height: h * 0.13,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.02),
            color: AppColors.white100
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.supervised_user_circle_sharp, color: AppColors.white70, size: w * 0.1,),
                SizedBox(width: w * 0.05,),
                Text('Referral Bonus',
                  style: TextStyle(
                      fontSize: w * 0.06,
                      fontFamily: 'madaBold'
                  ),),
              ],
            ),
            Text('\$ 30.00',
              style: TextStyle(
                  fontSize: w * 0.04,
                  fontFamily: 'madaBold'
              ),),
          ],
        ),
      ),
    );
  }

  Widget farmMoney(var h, var w) {
    return Container(
      width: w,
      height: h * 0.13,
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.001),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w * 0.02),
          color: AppColors.white100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.auto_graph_rounded, color: AppColors.white70, size: w * 0.1,),
              SizedBox(width: w * 0.05,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Farm Money',
                    style: TextStyle(
                        fontSize: w * 0.06,
                        fontFamily: 'madaBold'
                    ),),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text('Crypt-X Money',
                    style: TextStyle(
                        color: AppColors.white70,
                        fontSize: w * 0.035,
                        fontFamily: 'madaSemiBold'
                    ),),
                ],
              ),
            ],
          ),
          Text('\$ 30.00',
            style: TextStyle(
                fontSize: w * 0.04,
                fontFamily: 'madaBold'
            ),),
        ],
      ),
    );
  }

}
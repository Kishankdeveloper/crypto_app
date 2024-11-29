import 'package:crypto_app/modules/cryptx_wallet/wallet_info_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_money_bottomsheet.dart';

class WalletInfoScreen extends GetView<WalletInfoController>{
  const WalletInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return GetBuilder(
        builder: (WalletInfoController walletInfoController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.001),
                    decoration: BoxDecoration(
                      color: AppColors.info40.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(w * 0.02)
                    ),
                    child: Text('SPOT',
                    style: TextStyle(
                      color: AppColors.info60,
                      fontSize: w * 0.05,
                    ),),
                  )
                ],
              ),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                controller.homeDashboard();
                controller.transactionHistory();
              },
              child: SingleChildScrollView(
                child: Container(
                  width: w,
                  height: h,
                  padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                  child: Column(
                    children: [
                      Text('${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"} Wallet',
                      style: TextStyle(
                        color: AppColors.white60,
                        fontSize: w * 0.05,
                        fontFamily: 'madaBold'
                      ),),
                      Obx(() => controller.loading.value ?
                      Text('00.00 ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                        style: TextStyle(
                            fontSize: w * 0.07  ,
                            fontFamily: 'madaBold'
                        ),) :
                      Text('${controller.type == "USDT" ? Storage.getValue(Constants.usdtBalance) : controller.type == "X-Coin" ? Storage.getValue(Constants.xbtCoinBalance) : Storage.getValue(Constants.xbtBalance)} ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                        style: TextStyle(
                            fontSize: w * 0.07  ,
                            fontFamily: 'madaBold'
                        ),),),
                      /*Text('\$ 00.00',
                        style: TextStyle(
                          color: AppColors.white70,
                            fontSize: w * 0.05,
                            fontFamily: 'madaSemiBold'
                        ),),*/
                      SizedBox(
                        height: h * 0.01,
                      ),
                      balanceWidget(h, w),
                      PreferredSize(
                        preferredSize: Size(w, h * 0.06),
                        child: TabBar(
                          controller: controller.tabController,
                            labelStyle: TextStyle(
                              fontSize: w * 0.04,
                              fontFamily: 'madaSemiBold'
                            ),
                            unselectedLabelColor: AppColors.white80,
                            labelColor: AppColors.white50,
                            isScrollable: false,
                            labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: h * 0.001),
                            tabs: const [
                              Tab(
                                text: 'TRANSACTIONS',
                              ),
                              Tab(
                                text: 'MARKET',
                              )
                            ]
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                            children: [
                              transactionHistory(h, w),
                              withdrawalHistory(h, w)
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            persistentFooterButtons: controller.type == "X-Coin" || controller.type == "XBT" ? null : [Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(
                          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                          AddMoneyBottomSheet(
                            onTap: () {
                              controller.appKitModal.isConnected ?
                              controller.transferUSDT() :
                              WidgetUtils.showAlertDialogue(context, "Please Connect crypto wallet.");
                             // controller.openBlockExplorer();
                            },
                            loading: false,
                            amountController: controller.amountController,
                            onTapCrypto: (){
                              controller.appKitModal.isConnected ?
                              controller.appKitModal.disconnect(disconnectAllSessions: true)  :
                              controller.appKitModal.openModalView();
                            },
                            appKitModal: controller.appKitModal,
                          ),
                          isScrollControlled: true, // to make the sheet full-screen if necessary
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(w/2, h * 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.03)
                          )
                      ),
                      child: Text('Deposit'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.white60,
                            letterSpacing: w * 0.001,
                            fontSize: w * 0.045,
                            fontFamily: 'madaSemiBold'
                        ),)
                  ),
                ),
                SizedBox(width: w * 0.02,),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        WidgetUtils.showSnackbar("coming soon");
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(w/2, h * 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.03)
                          )
                      ),
                      child: Text('Withdrawal'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.white60,
                            letterSpacing: w * 0.001,
                            fontSize: w * 0.045,
                            fontFamily: 'madaSemiBold'
                        ),)
                  ),
                )
              ],
            )],
            primary: true,
            persistentFooterAlignment: AlignmentDirectional.bottomStart,
          );
        });
  }

  Widget balanceWidget(var h, var w) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        width: w,
        height: h * 0.1,
        padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.02),
            color: AppColors.white100
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('AVAILABLE',
                style: TextStyle(
                  color: AppColors.white70,
                  fontFamily: 'madaSemiBold',
                  fontSize: w * 0.04
                ),),
                Obx(() => controller.loading.value ?
                Text('00.00 ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),) :
                Text('${controller.type == "USDT" ? Storage.getValue(Constants.usdtBalance) : controller.type == "X-Coin" ? Storage.getValue(Constants.xbtCoinBalance) : Storage.getValue(Constants.xbtBalance)} ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),))
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('IN ORDER',
                  style: TextStyle(
                      color: AppColors.white70,
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),),
                Obx(() => controller.loading.value ?
                Text('00.00 ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),) :
                Text('${controller.usdtInOrder.value} ${controller.type == "USDT" ? "USDT" : controller.type == "X-Coin" ? "X-Coin" : "XBT"}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionHistory(var h, var w) {
    return Obx(() => controller.loading.value ?
    const SizedBox.shrink() :
    controller.transactionListData == null || controller.transactionListData!.isEmpty ?
    Text('No Transactions Available',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'madaRegular',
          fontSize: w * 0.04
      ),) :
    ListView.builder(
      shrinkWrap: true,
       // physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: h * 0.15),
        itemCount: controller.transactionListData?.length,
        itemBuilder: (context, index) {
          final data = controller.transactionListData?[index];
          final backgroundColor = index % 2 == 0 ? Colors.black87 : AppColors.white100;
          return Container(
            height: h * 0.1,
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      data?.creditDebitType == 'credit' ? CupertinoIcons.arrow_down_left : data?.creditDebitType == 'debit' && data?.transactionType != 'Reject' ? CupertinoIcons.arrow_up_right : data?.creditDebitType == 'debit' && data?.transactionType == 'Reject' ? Icons.close : Icons.add,
                      color: data?.creditDebitType == 'credit' ? AppColors.success40 : AppColors.error60,
                      size: w * 0.07,
                    ),
                    SizedBox(width: w * 0.02,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data?.transactionType}' /*'${data?.transactionType  == "Withdrawal" || data?.transactionType == "Deposit" ? "Swap" : data?.transactionType}'*/,
                          style: TextStyle(
                              color: AppColors.white40,
                              fontFamily: 'madaRegular',
                              fontSize: w * 0.05
                          ),),
                        Text('${data?.transactionDate}',
                          style: TextStyle(
                              color: AppColors.white60,
                              fontFamily: 'madaRegular',
                              fontSize: w * 0.03
                          ),)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${data?.amount}',
                      style: TextStyle(
                          color: data?.creditDebitType == 'credit' ? AppColors.success60 : AppColors.error60,
                          fontFamily: 'madaRegular',
                          fontSize: w * 0.05
                      ),),
                    SizedBox(width: w * 0.02,),
                    Text(
                      '${data?.currency}',
                      style: TextStyle(
                          color: AppColors.white70,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.04
                      ),),
                  ],
                ),
              ],
            ),
          );
        }));
  }

  Widget withdrawalHistory(var h, var w) {
    return Column(
      children: [
        SizedBox(
          height: h * 0.1,
        ),
        Image.asset('assets/images/maintenance.png', width: w * 0.3, fit: BoxFit.cover,),
        SizedBox(
          height: h * 0.02,
        ),
        Text('Market under\nmaintenance',
        textAlign: TextAlign.center,
        softWrap: true,
        style: TextStyle(
          fontSize: w * 0.06,
          fontFamily: 'madaSemiBold',
        ),),
        Text('Our best minds are working on the backend to make your experience better. We\'ll right back.',
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            color: AppColors.white50,
            fontSize: w * 0.03,
            fontFamily: 'madaRegular',
          ),)
      ],
    );
  }

}
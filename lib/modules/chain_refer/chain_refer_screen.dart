import 'package:crypto_app/modules/chain_refer/chain_refer_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ChainReferScreen extends GetView<ChainReferController> {
  const ChainReferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: ChainReferController(),
        builder: (ChainReferController chanReferController) {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            controller.homeDashboard();
            chanReferController.getReferList();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: h * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: h * 0.04,
                ),
                titleWidget(h, w),
                SizedBox(
                  height: h * 0.04,
                ),
                inviteWidget(h, w),
                SizedBox(
                  height: h * 0.02,
                ),
                telegramWidget(h, w),
                SizedBox(
                  height: h * 0.02,
                ),
                directWidget(h, w),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Number of friends invited by you(${controller.referList?.length ?? 0})',
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontFamily: 'madaSemiBold'
                      ),),
                    IconButton(
                        onPressed: (){
                        controller.getReferList();
                        },
                        icon: const Icon(Icons.sync)
                    )
                  ],
                ),
                Obx(() =>
                controller.loading.value ?
                const SizedBox.shrink() :
                controller.referList == null || controller.referList!.isEmpty ?
                Text('No referred users found',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaRegular'
                  ),) :
                friendsList(h, w) ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          inviteBtnWidget(h, w)
        ],
      );
    });
  }

  Widget titleWidget(var h, var w) {
    return Column(
      children: [
        Text('Invite friends!',
        style: TextStyle(
          fontSize: w * 0.1,
          fontFamily: 'madaSemiBold'
        ),),
        /*SizedBox(
          height: h * 0.01,
        ),*/
        Text('You and your friends will receive bonuses',
          style: TextStyle(
              fontSize: w * 0.04,
              fontFamily: 'madaRegular'
          ),)
      ],
    );
  }
  
/*  Widget inviteWidget(var h, var w) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: w,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/gift.png',
            width: w * 0.13,
            height: w * 0.13,
            fit: BoxFit.cover,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Invite a friend',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaSemiBold'
                  ),),
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.yellow, size: w * 0.025),
                    SizedBox(width: w * 0.02,),
                    Image.asset('assets/images/diamond.png', width: w * 0.06,),
                    SizedBox(width: w * 0.02,),
                    Text('+0.1', style: TextStyle(
                      color: Colors.yellow,
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                    ),),
                    SizedBox(width: w * 0.02,),
                    Text('for you and your friends', style: TextStyle(
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.04
                    ),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }*/

  Widget inviteWidget(var h, var w) {
    return GestureDetector(
      onTap: () {
        WidgetUtils.inviteFriend("https://play.google.com/store/apps/details?id=com.kishan.crypto.crypto_app", "${Storage.getValue(Constants.referCode)}".toUpperCase());
      },
      child: Container(
        width: w,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: w * 0.02,),
            Image.asset('assets/images/gift-box.png',
              width: w * 0.15,
              height: w * 0.15,
              fit: BoxFit.cover,),
            SizedBox(width: w * 0.04,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invite a friend',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: w * 0.04,
                        fontFamily: 'madaSemiBold'
                    ),),
                  SizedBox(
                    height: h * 0.001,
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.yellow, size: w * 0.025),
                      SizedBox(width: w * 0.02,),
                      /*Image.asset('assets/images/diamond.png', width: w * 0.06,),*/
                      Text('X', style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'madaBold',
                          fontSize: w * 0.05
                      ),),
                      SizedBox(width: w * 0.02,),
                      Text('+3000', style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.04
                      ),),
                      SizedBox(width: w * 0.02,),
                      Text('for you and your friends', style: TextStyle(
                          fontFamily: 'madaRegular',
                          fontSize: w * 0.04
                      ),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget directWidget(var h, var w) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: w,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/indirect.png',
              width: w * 0.2,
              height: w * 0.2,
              fit: BoxFit.cover,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Extra rewards from friends',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaSemiBold'
                  ),),
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.yellow, size: w * 0.025),
                    SizedBox(width: w * 0.02,),
                  /*  Text('X', style: TextStyle(
                        color: Colors.amber,
                        fontFamily: 'madaBold',
                        fontSize: w * 0.05
                    ),),*/
                    /*Image.asset('assets/images/diamond.png', width: w * 0.06,),*/
                    SizedBox(width: w * 0.02,),
                    Text('12% ', style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'madaSemiBold',
                        fontSize: w * 0.04
                    ),),
                    Text(' direct and', style: TextStyle(
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.04
                    ),),
                    SizedBox(width: w * 0.02,),
                    Text('8% ', style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'madaSemiBold',
                        fontSize: w * 0.04
                    ),),
                    Text(' indirect deposit', style: TextStyle(
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.04
                    ),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /*Widget telegramWidget(var h, var w) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: w,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/gift-box.png',
              width: w * 0.13,
              height: w * 0.13,
              fit: BoxFit.cover,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Invite a friend with telegram premium',
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontFamily: 'madaSemiBold'
                  ),),
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.yellow, size: w * 0.025),
                    SizedBox(width: w * 0.02,),
                    Image.asset('assets/images/diamond.png', width: w * 0.06,),
                    SizedBox(width: w * 0.02,),
                    Text('+0.3', style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'madaSemiBold',
                        fontSize: w * 0.04
                    ),),
                    SizedBox(width: w * 0.02,),
                    Text('for you and your friends', style: TextStyle(
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.04
                    ),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }*/

  Widget telegramWidget(var h, var w) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: w,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: w * 0.02,),
            Image.asset('assets/images/gift-box.png',
              width: w * 0.15,
              height: w * 0.15,
              fit: BoxFit.cover,),
            SizedBox(width: w * 0.04,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refer Your Friend Now ! To Get Exciting Rewards..',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: w * 0.035,
                        fontFamily: 'madaSemiBold'
                    ),),
                  SizedBox(
                    height: h * 0.001,
                  ),
                 /* Row(
                    children: [
                      Icon(Icons.circle, color: Colors.yellow, size: w * 0.025),
                      SizedBox(width: w * 0.02,),
                      *//*Image.asset('assets/images/diamond.png', width: w * 0.06,),*//*
                      Text('X', style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'madaBold',
                          fontSize: w * 0.05
                      ),),
                      SizedBox(width: w * 0.02,),
                      Text('+23000', style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.04
                      ),),
                      SizedBox(width: w * 0.02,),
                      Text('for you and your friends', style: TextStyle(
                          fontFamily: 'madaRegular',
                          fontSize: w * 0.04
                      ),)
                    ],
                  )*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget friendsList(var h, var w) {
    return Column(
      children: List.generate(
          controller.referList!.length,
              (index) {
            final item = controller.referList?[index];
            return Container(
              width: w,
              height: h * 0.08,
              padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
              margin: EdgeInsets.only(bottom: h * 0.02),
              decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(w * 0.04)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/rabbit.png',
                        width: w * 0.1,),
                      SizedBox(
                        width: w * 0.05,
                      ),
                      Text('${item?.name}  (${item?.referredUsersCount ?? '0'})',
                        style: TextStyle(
                            fontFamily: 'madaSemiBold',
                            fontSize: w * 0.04
                        ),),
                      SizedBox(
                        height: w * 0.02,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/x-coin.png', width: w * 0.06,),
                      SizedBox(width: w * 0.02,),
                      Text('+${item?.xcoinBalance ?? '0.00'} ',
                        style: TextStyle(
                            fontFamily: 'madaSemiBold',
                            fontSize: w * 0.04
                        ),),
                    ],
                  ),
                ],
              ),
            );
          }

      ),
    );
  }

  Widget inviteBtnWidget(var h, var w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              WidgetUtils.inviteFriend("https://play.google.com/store/apps/details?id=com.kishan.crypto.crypto_app", "${Storage.getValue(Constants.referCode)}".toUpperCase());
            },
            child: Container(
              height: h * 0.06,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(w * 0.04)
              ),
              child: Center(child: Text('Invite Friends',
              style: TextStyle(
                color: AppColors.white10,
                fontSize: w * 0.04,
                fontFamily: 'madaSemiBold'
              ),)),
            ),
          ),
        ),
        SizedBox(width: w * 0.03),
        Expanded(
          child: Container(
            height: h * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            child: GestureDetector(
              onTap: () {
                WidgetUtils.copyToClipboard(Get.context!, "${Storage.getValue(Constants.referCode)}".toUpperCase());
              },
              child: DottedBorderWidget(
                color: AppColors.primary,
                radius: w * 0.03,
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${Storage.getValue(Constants.referCode)}".toUpperCase(),style: TextStyle(
                          fontSize: w * 0.06,
                          fontFamily:'madaSemiBold'
                        ),),
                        SizedBox(width: w * 0.02,),
                        const Icon(Icons.copy, color: AppColors.white10,),
                      ],
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
  
}
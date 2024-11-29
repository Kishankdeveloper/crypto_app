import 'package:crypto_app/modules/x_chain/x_chain_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/dprint.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XChainScreen extends GetView<XChainController> {
  const XChainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: XChainController(),
        builder: (XChainController xChainController) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.homeDashboard();
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: h/1.15,
                    padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text('Swap',
                              style: TextStyle(
                                  fontFamily: 'madaBold',
                                  fontSize: w * 0.09
                              ),),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            swapContainer(h, w),
                            SizedBox(
                              height: h * 0.04,
                            ),
                            Text('1 USDT = 18 XBT',
                              style: TextStyle(
                                  color: AppColors.error60,
                                  fontSize: w * 0.05,
                                  fontFamily: 'madaSemiBold'
                              ),),
                            SizedBox(
                              height: h * 0.01
                            ),
                            buttonWidget(h, w)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
  Widget swapContainer(var h, var w) {
    return Container(
      width: w,
      padding: EdgeInsets.all(w * 0.02),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(w * 0.03)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('From',
              style: TextStyle(
                color: AppColors.white70,
                fontSize: w * 0.04,
                fontFamily: 'madaRegular'
              ),),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined, color: AppColors.white70, size: w * 0.05,),
                  SizedBox(width: w * 0.03,),
                  Text('${Storage.getValue(Constants.usdtBalance)}',
                  style: TextStyle(
                    color: AppColors.white70,
                    fontSize: w * 0.04,
                    fontFamily: 'madaRegular'
                  ),),
                ],
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.08,
                    width: w * 0.12,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: w * 0.05,
                          backgroundImage: const AssetImage('assets/images/usdt_icon.png'),
                        ),
                        Positioned(
                          bottom: 20,
                            right: 0,
                            child: CircleAvatar(
                          radius: w * 0.025,
                          backgroundColor: AppColors.white100,
                              backgroundImage: const AssetImage('assets/images/x-coin.png'),
                        )
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: w * 0.03,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('USDT',
                            style: TextStyle(
                                fontFamily: 'madaSemiBold',
                              fontSize: w * 0.05
                            ),),
                          Obx(() => Text(controller.loading.value ? '0.00' : '${Storage.getValue(Constants.usdtBalance)}',
                            style: TextStyle(
                                color: AppColors.white60,
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.03
                            ),))
                        ],
                      ),
                      SizedBox(width: w * 0.02,),
                      GestureDetector(
                        onTap: (){},
                        child: Icon(Icons.keyboard_arrow_down_outlined, size: w * 0.07, color: AppColors.white70,),
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: TextField(
                  controller: controller.usdtController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: AppColors.white60,
                      fontSize: w * 0.06,
                      fontFamily: 'madaSemiBold'
                  ),
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      hintText: '0.00',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: AppColors.white70,
                          fontSize: w * 0.06,
                          fontFamily: 'madaBold'
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero
                  ),
                  onChanged: (value) {
                    if(value.isEmpty || value == "") {
                      controller.xbtController.clear();
                    } else {
                      controller.xbtController.text = controller.xbtValue().value.toString();
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          GestureDetector(
            child: CircleAvatar(
              radius: w * 0.04,
              backgroundColor: AppColors.white80,
              child: Icon(CupertinoIcons.arrow_up_arrow_down, size: w * 0.05, color: AppColors.white50,),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('To',
                style: TextStyle(
                    color: AppColors.white70,
                    fontSize: w * 0.04,
                    fontFamily: 'madaRegular'
                ),),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined, color: AppColors.white70, size: w * 0.05,),
                  SizedBox(width: w * 0.03,),
                  Text('${Storage.getValue(Constants.xbtBalance)}',
                    style: TextStyle(
                        color: AppColors.white70,
                        fontSize: w * 0.04,
                        fontFamily: 'madaRegular'
                    ),),
                ],
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.08,
                    width: w * 0.12,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: w * 0.05,
                          backgroundImage: const AssetImage('assets/images/x-coin.png',),
                        ),
                        Positioned(
                            bottom: 20,
                            right: 0,
                            child: CircleAvatar(
                              radius: w * 0.025,
                              backgroundColor: AppColors.white100,
                              backgroundImage: const AssetImage('assets/images/x-coin.png'),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: w * 0.03,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('XBT',
                            style: TextStyle(
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.05
                            ),),
                          Obx(() => Text(controller.loading.value ? '0.00' : '${Storage.getValue(Constants.xbtBalance)}',
                            style: TextStyle(
                                color: AppColors.white60,
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.03
                            ),))
                        ],
                      ),
                      SizedBox(width: w * 0.02,),
                      GestureDetector(
                        onTap: (){},
                        child: Icon(Icons.keyboard_arrow_down_outlined, size: w * 0.07, color: AppColors.white70,),
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                  child: TextField(
                    controller: controller.xbtController,
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: AppColors.white60,
                        fontSize: w * 0.06,
                        fontFamily: 'madaSemiBold'
                    ),
                    decoration: InputDecoration(
                        hintText: '0.00',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                            color: AppColors.white70,
                            fontSize: w * 0.06,
                            fontFamily: 'madaBold'
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero
                    ),
                    onChanged: (value) {

                    },
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          controller.swap();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Swap',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }
  
}
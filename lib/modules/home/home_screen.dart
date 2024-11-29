import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/modules/home/home_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utills/dprint.dart';
import '../../utills/painter/liquid_painter.dart';
import '../../utills/painter/radial_painter.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: HomeController(),
        builder: (HomeController homeController) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.homeDashboard();
                },
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: h * 0.01,
                        ),
                        appBarWidget(h, w),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        walletWidget(h, w),
                        SizedBox(
                          height: h * 0.07,
                        ),
                        bottomSheet(h, w)
                      ],
                    ),
                    Obx(() => controller.rewardShow.value ?
                    Lottie.asset('assets/images/confetti.json',
                      repeat: true,
                    ) : const SizedBox.shrink())
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bottomSheet(var h, var w) {
    return Container(
      width: w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(w * 0.1), topRight: Radius.circular(w * 0.1)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 30,
            color: AppColors.info80.withOpacity(0.5),
            offset: const Offset(0, - 20), // Shift shadow upwards
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Text('Our Project',
          style: TextStyle(
            fontFamily: 'madaSemibold',
            fontSize: w * 0.05
          ),),
          balanceWidget(h, w),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('X', style: TextStyle(
                  fontSize: w * 0.1,
                  color: Colors.amber,
                  fontFamily: 'madaBold'
              ),),
              SizedBox(width: w * 0.04,),
              Image.asset('assets/images/coins.png', width: w * 0.1,),
              SizedBox(width: w * 0.04,),
              Obx(() => Text(controller.loading.value ? '0' : (controller.homeData?.xcoinBalance).toString(), style: TextStyle(
                  fontSize: w * 0.07,
                  fontFamily: 'madaBold'
              ),))
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          farmButtonWidget(h, w)
        ],
      ),
    );
  }

  Widget appBarWidget(var h, var w){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              // profile clicks
            //  controller.showAnimation(Get.context!);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: w * 0.06,
                  backgroundColor: AppColors.primary,
                  child: CircleAvatar(
                    radius: w * 0.055,
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.01),
                      child: CircleAvatar(
                        radius: w * 0.045,
                        backgroundImage: const CachedNetworkImageProvider('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04,),
                Obx(() => Text(controller.loading.value ? '' : 'Hi ${controller.homeData?.name ?? ''}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.04
                  ),))
              ],
            ),
          ),
          popUpMenuWidget(h, w)
        ],
      ),
    );
  }
  
  Widget walletCoinWidget(var h, var w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h * 0.02),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(w * 0.04),
        child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.white.withOpacity(0.4), Colors.transparent],
                      begin: Alignment(-1.0 + 3.0 * controller.animationController.value, -1.0),
                      end: Alignment(1.0 - 2.0 * controller.animationController.value, 2.0),
                    ).createShader(bounds);
                  },
                blendMode: BlendMode.srcOver,
                child: Container(
                  height: h * 0.15,
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.05),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6603FC), Color(0xFFca03fc)], // specify start and end colors
                      begin: Alignment.topLeft, // start point of the gradient
                      end: Alignment.bottomRight, // end point of the gradient
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Text('Total X-Coins',
                      style: TextStyle(
                        color: AppColors.white10,
                        fontSize: w * 0.05,
                        fontFamily: 'madaSemiBold'
                      ),),
                      Obx(() => Text(controller.loading.value ? 'X 0.00' : 'X ${Storage.getValue(Constants.xbtCoinBalance)}',
                        style: TextStyle(
                            fontFamily: 'madaBold',
                            fontSize: w * 0.1
                        ),))
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  Widget farmButtonWidget(double h, double w) {
    return Obx(() {
      // Calculate progress value for the progress indicator
      double progressValue = controller.progressIndicator.value * HomeController.totalTimeInSeconds;
      return controller.isPlaying.value && !controller.showClaim.value ?
      _buildProgressWidget(h, w, progressValue) : 
      !controller.isPlaying.value && controller.showClaim.value ? _buildClaimButton(w) :
       _buildStartFarmingButton(w);
      // Show Claim Button
    /*  if (controller.showClaim.value) {
        return _buildClaimButton(w);
      }

      // Show Progress Animation
      if (controller.isPlaying.value) {
        return _buildProgressWidget(h, w, progressValue);
      }

      // Show Start Farming Button*/
   //   return _buildStartFarmingButton(w);
    });
  }

// Separate method for the Claim Button
  Widget _buildClaimButton(double w) {
    return GestureDetector(
      onTap: controller.claimReward,
      child: CircleAvatar(
        radius: w * 0.3,
        backgroundColor: Colors.black,
        backgroundImage: const AssetImage('assets/images/claim.png'),
        child: Text(
          'Claim',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'madaBold',
            fontSize: w * 0.13,
          ),
        ),
      ),
    );
  }

// Separate method for the Progress Animation Widget
  Widget _buildProgressWidget(double h, double w, double progressValue) {
    return GestureDetector(
      onTap: controller.startMining,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: w * 0.5,
            height: w * 0.5,
            child: AnimatedBuilder(
              animation: controller.progressIndicator,
              builder: (context, _) {
                return Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Liquid Fill Painter
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CustomPaint(
                          painter: LiquidPainter(
                            progressValue,
                            HomeController.totalTimeInSeconds.toDouble(),
                          ),
                        ),
                      ),
                      // Radial Progress Painter
                      CustomPaint(
                        painter: RadialProgressPainter(
                          value: progressValue,
                          backgroundGradientColors: controller.gradientColors,
                          minValue: 0,
                          maxValue: HomeController.totalTimeInSeconds.toDouble(),
                        ),
                      ),
                      // Remaining Time Display
                      _buildRemainingTime(h, w),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

// Separate method for Remaining Time Display
  Widget _buildRemainingTime(double h, double w) {
    return Positioned(
      top: h * 0.09,
      left: 0,
      right: 0,
      child: Obx(() {
        int hours = controller.remainingTime.value ~/ 3600;
        int minutes = (controller.remainingTime.value % 3600) ~/ 60;
        int seconds = controller.remainingTime.value % 60;

        return Text(
          "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} \n 252 / 40 M",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.05,
            fontFamily: 'madaBold',
          ),
        );
      }),
    );
  }

// Separate method for the Start Farming Button
  Widget _buildStartFarmingButton(double w) {
    return GestureDetector(
      onTap: controller.startMining,
      child: CircleAvatar(
        radius: w * 0.25,
        backgroundImage: const AssetImage('assets/images/circle.png'),
        child: Text(
          'Start Farming\n252 - 40M',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'madaBold',
            fontSize: w * 0.04,
          ),
        ),
      ),
    );
  }


  Widget walletWidget(var h, var w) {
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.01),
      margin: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.black87, // Adjust to match the background color
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.info60.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 5,
            //offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left icon
          Image.asset('assets/images/x-coin.png', width: w * 0.12, fit: BoxFit.cover,), // Replace with your desired icon
          SizedBox(width: w * 0.01),
          // Divider
          Container(
            height: h  * 0.05,
            width: 1.0,
            color: Colors.grey[700],
          ),
          //SizedBox(width: w * 0.01),
          // Text and center icons
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wallet Balance',
                style: TextStyle(
                  fontFamily: 'madaRegular',
                  fontSize: w * 0.04,
                  color: Colors.white54
                ),
              ),
              Row(
                children: [
                 // Image.asset('assets/images/diamond.png', width: w * 0.08,),
                  SizedBox(width: w * 0.05),
                  Obx(() => Text(controller.loading.value ? 'XBT 0.00' : 'XBT ${controller.homeData?.xbtBalance ?? ''}',
                    style: TextStyle(
                        fontFamily: 'madaSemiBold',
                        fontSize:w * 0.05
                    ),)),
                  SizedBox(width: w * 0.05),
                 // Icon(Icons.info, color: Colors.grey[600]),
                ],
              ),
            ],
          ),

         // SizedBox(width: w * 0.01),

          // Divider
         /* Container(
            height: h  * 0.05,
            width: 1.0,
            color: Colors.grey[700],
          ),

          SizedBox(width: w * 0.01),

          // Right icon
          Icon(Icons.settings, color: Colors.grey[400], size: w * 0.08,),*/
        ],
      ),
    );
  }

  Widget balanceWidget(var h, var w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            WidgetUtils.showAlertDialogue(Get.context!, "Coming soon");
          },
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, build) {
              return Container(
                width: w * 0.2, // Adjust width as needed
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColors.white80,
                  borderRadius: BorderRadius.circular(w * 0.03),
                  border: Border.all(color: controller.borderColor.value ?? AppColors.primary, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: h * 0.01),
                    // Game image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.05),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/4843/4843246.png',
                        height: h * 0.06,
                        width: w ,
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    // Game title
                    Text(
                      'Exchange',
                      style: TextStyle(
                        fontFamily: 'madaSemiBold',
                        fontSize: w * 0.03,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: h * 0.01),
                    // Diamond badge
                   /* AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, child) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.004),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(w * 0.04),
                              border: Border.all(color: controller.borderColor.value ?? Colors.yellow, width: 2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/diamond.png', width:  w * 0.03,),
                                SizedBox(width: w * 0.02),
                                Text(
                                  'X  20',
                                  style: TextStyle(
                                    fontFamily: 'madaSemiBold',
                                    fontSize: w * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    ),*/

                    SizedBox(height: h * 0.005),
                  ],
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            WidgetUtils.showAlertDialogue(Get.context!, "Coming soon");
          },
          child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, build) {
                return Container(
          width: w * 0.2, // Adjust width as needed
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: AppColors.white80,
            borderRadius: BorderRadius.circular(w * 0.03),
            border: Border.all(color: controller.borderColor.value ?? AppColors.primary, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.01),
              // Game image
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.05),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/10810/10810041.png',
                  height: h * 0.06,
                  width: w ,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: h * 0.01),

              // Game title
              Text(
                'Social Media',
                style: TextStyle(
                  fontFamily: 'madaSemiBold',
                  fontSize: w * 0.03,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: h * 0.01),

              // Diamond badge
             /* AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.004),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(w * 0.04),
                        border: Border.all(color: controller.borderColor.value ?? Colors.yellow, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/diamond.png', width:  w * 0.03,),
                          SizedBox(width: w * 0.02),
                          Text(
                            'X  30',
                            style: TextStyle(
                              fontFamily: 'madaSemiBold',
                              fontSize: w * 0.03,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),*/

              SizedBox(height: h * 0.005),
            ],
          ),
                );
              }
          ),
        ),
        GestureDetector(
          onTap: () {
            WidgetUtils.showAlertDialogue(Get.context!, "Coming soon");
          },
          child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, build){
                return Container(
                  width: w * 0.2, // Adjust width as needed
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: AppColors.white80,
                    borderRadius: BorderRadius.circular(w * 0.03),
                    border: Border.all(color: controller.borderColor.value ?? AppColors.primary, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 0.01),
                      // Game image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/5636/5636701.png',
                          height: h * 0.06,
                          width: w ,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: h * 0.01),

                      // Game title
                      Text(
                        'E-Identity',
                        style: TextStyle(
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: h * 0.01),

                      // Diamond badge
                      /*AnimatedBuilder(
                          animation: controller.animationController,
                          builder: (context, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.004),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(w * 0.04),
                                border: Border.all(color: controller.borderColor.value ?? Colors.yellow, width: 2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/diamond.png', width:  w * 0.03,),
                                  SizedBox(width: w * 0.02),
                                  Text(
                                    'X  40',
                                    style: TextStyle(
                                      fontFamily: 'madaSemiBold',
                                      fontSize: w * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),*/

                      SizedBox(height: h * 0.005),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget popUpMenuWidget(var h, var w) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'logout') {
          // Handle the logout action
          dprint('User logged out');
          //  WidgetUtils.showLogoutDialogue(context, 'Are you sure want to logout');
          controller.showLogoutDialogue(Get.context!, 'Are you sure want to logout');
        } else if(value == 'profile'){
          Get.toNamed(Routes.profile);
        }else if(value == 'kyc'){
          WidgetUtils.showSnackbar('Coming Soon');
        } else if(value == 'updatePass') {
          Get.toNamed(Routes.updatePassword, arguments: {
            "type" : "new"
          });
        }
      },
      icon: const CircleAvatar(
        backgroundColor: AppColors.white100,
        child: Icon(Icons.settings),
      ),
      offset: const Offset(0, 60),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(horizontal: w * 0.02,vertical: w*0.02),
            height: 20,
            value: 'profile',
            child: Row(
              children: [
                Icon(Icons.person_4_rounded,size: w * 0.05,),
                const SizedBox(width: 8),
                Text('Profile',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),
          PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(horizontal: w * 0.02,vertical: w*0.02),
            height: 20,
            value: 'updatePass',
            child: Row(
              children: [
                Icon(Icons.password_sharp,size: w * 0.05,),
                const SizedBox(width: 8),
                Text('Update password',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),
          PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(horizontal: w * 0.02,vertical: w*0.02),
            height: 20,
            value: 'kyc',
            child: Row(
              children: [
                Icon(Icons.verified_rounded,size: w * 0.05,),
                const SizedBox(width: 8),
                Text('KYC',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),
          PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(horizontal: w * 0.02,vertical: w*0.02),
            height: 20,
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout,size: w * 0.05,),
                const SizedBox(width: 8),
                Text('Logout',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),
        ];
      },
    );
  }

}
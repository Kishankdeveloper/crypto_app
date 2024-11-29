import 'dart:async';
import 'dart:convert';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/home_model.dart';
import 'package:crypto_app/network_services/models/start_mining_model.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utills/app_colors.dart';
import '../../utills/app_pages.dart';
import '../../utills/dprint.dart';
import '../../utills/mining_service.dart';
import '../../utills/notification_service.dart';
import '../../utills/storage.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin{

  late AnimationController animationController;

  late AnimationController progressIndicator;

  static const int totalTimeInSeconds = 2400; // 360 minutes in seconds
  RxInt remainingTime = totalTimeInSeconds.obs;
  Timer? timer;
  RxBool isPlaying = false.obs;
  late Animation<Color?> borderColor;
  HomeData? homeData;
  RxBool rewardShow = false.obs;

  List<Color> gradientColors = const [
    Color(0xffFF0069),
    Color(0xffFED602),
    Color(0xff7639FB),
    Color(0xffD500C5),
    Color(0xffFF7A01),
    Color(0xffFF0069),
  ];

  final ApiHelper _apiHelper = ApiHelper.to;

  RxBool showClaim = false.obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Retrieve and parse the start time
    String? startTimeString = Storage.getValue(Constants.miningStartTime);
    DateTime? startTime = startTimeString != null ? DateTime.tryParse(startTimeString) : null;

    if (startTime != null) {
      int elapsedTime = DateTime.now().difference(startTime).inSeconds;

      if (elapsedTime >= totalTimeInSeconds) {
        showClaim.value = true; // Hide claim option
        isPlaying.value = false; // Stop playing (timer is over)
        debugPrint("Timer finished, process stopped. startTime: $startTime seconds Elapsed: $elapsedTime seconds, Total: $totalTimeInSeconds seconds");
      } else {
        remainingTime.value = totalTimeInSeconds - elapsedTime;
        startTimer();
      }
    } else {
      dprint("Invalid or missing start time");
    }

    // Initialize animation controller (outside of onInit to avoid recreating it)
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Initialize border color animation (outside of onInit to avoid recreating it)
    borderColor = ColorTween(
      begin: Colors.amber.withOpacity(0.1),
      end: Colors.amberAccent,
    ).animate(animationController);

    // Initialize progress indicator (outside of onInit to avoid recreating it)
    progressIndicator = AnimationController(
      vsync: this,
      duration:  Duration(seconds: remainingTime.value),
    )..addListener(() {
      update();
    })..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
       // isPlaying.value = false;
      }
    });

    Future.microtask(() => homeDashboard());
  }

  // Calculating progress
  double get progress => 1 - (remainingTime.value / totalTimeInSeconds);

  Future<void> startTimer() async {
    if (isPlaying.value) {
      // Stop the timer
      await AndroidAlarmManager.cancel(0); // Cancel any existing alarm
      isPlaying.value = false;
      progressIndicator.reset();
      remainingTime.value = totalTimeInSeconds; // Reset to total time
      return;
    }

    // Start Android alarm for the total time (for system-level accuracy)
    await AndroidAlarmManager.oneShot(
      Duration(seconds: remainingTime.value),
      0, // Alarm ID
      showMiningCompleteNotification,
      exact: true,
      wakeup: true,
    );
    dprint("claim agya3==>${showClaim.value}");
    // Start the progress indicator animation
    progressIndicator.duration = Duration(seconds: remainingTime.value);
    progressIndicator.forward(from: 1 - (remainingTime.value / totalTimeInSeconds));
    dprint("claim agya ==>${showClaim.value}");
    // Start periodic updates for the remaining time
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
        dprint("showClaim time==>${showClaim.value}");
        dprint("remaining time==>${remainingTime.value}");
      } else {
        // Stop the timer when finished
        dprint("claim agya==>${showClaim.value}");
        timer.cancel();
        progressIndicator.reset();
        isPlaying.value = false;
        showClaim.value = true;
        MiningService.stopMiningService();
      }
    });

    isPlaying.value = true;
    //showClaim.value = false;
  }

  void logout() async {
    await Storage.clearStorage();
    Get.offNamedUntil(Routes.login, (routes) => false);
  }

  Future showLogoutDialogue(BuildContext context, String title) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w*0.06),
          ),
          //backgroundColor: Colors.white,
          //surfaceTintColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the dialog takes only the required height
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //   color: AppColors.white70,
                    fontFamily: 'madaSemiBold',
                    fontSize: w * 0.04,
                  ),
                ),
                SizedBox(height: h*0.02),
                const Divider(height: 1.0, color: AppColors.white40),
                SizedBox(height: h*0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.07),
                              side: const BorderSide(
                                  color: AppColors.kPrimaryColor
                              )
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontFamily: 'madaSemiBold',
                            fontSize: w * 0.05,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w*0.03,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.07),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: AppColors.white10,
                            fontFamily: 'madaSemiBold',
                            fontSize: w * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
        if(Storage.hasData(Constants.email)){
          Storage.removeValue(Constants.email);
        }
        if(Storage.hasData(Constants.userName)){
          Storage.removeValue(Constants.userName);
        }
        if(Storage.hasData(Constants.xbtBalance)){
          Storage.removeValue(Constants.xbtBalance);
        }
        if(Storage.hasData(Constants.xbtCoinBalance)){
          Storage.removeValue(Constants.xbtCoinBalance);
        }
        if(Storage.hasData(Constants.mobile)){
          Storage.removeValue(Constants.mobile);
        }
        if(Storage.hasData(Constants.usdtBalance)){
          Storage.removeValue(Constants.usdtBalance);
        }
        if(Storage.hasData(Constants.referCode)){
          Storage.removeValue(Constants.referCode);
        }
        if(Storage.hasData(Constants.referBy)){
          Storage.removeValue(Constants.referBy);
        }

        //save storage data in local
        Storage.saveValue(Constants.email, res.data!.email.toString());
        Storage.saveValue(Constants.userName, res.data?.name.toString() ?? "");
        Storage.saveValue(Constants.xbtBalance, res.data!.xbtBalance.toString());
        Storage.saveValue(Constants.xbtCoinBalance, res.data!.xcoinBalance.toString());
        Storage.saveValue(Constants.mobile, res.data!.mobileNo.toString());
        Storage.saveValue(Constants.usdtBalance, res.data!.usdtBalance.toString());
        Storage.saveValue(Constants.referCode, jsonDecode(v)["data"]["referral_code"].toString() ?? "abcf");
        Storage.saveValue(Constants.referBy, res.data!.referredBy.toString());
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "something went wrong");
      }
      loading.value = false;
    }, retryFunction: homeDashboard);
  }

  Future<void> startMining() async {
    var payload = {
      "user_id": Storage.getValue(Constants.userId).toString(),
      "action": "start_mining"
    };

    if (isPlaying.value) {
      return WidgetUtils.showAlertDialogue(Get.context!, 'Mining Progress is already running');
    }
    _apiHelper.startMining(jsonEncode(payload)).futureValue((v) {
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if (res.status ?? false) {

        if(Storage.hasData(Constants.miningStartTime)){
          Storage.removeValue(Constants.miningStartTime);
        }
        remainingTime.value = totalTimeInSeconds;
        DateTime now = DateTime.now();
        Storage.saveValue(Constants.miningStartTime, now.toIso8601String()); // Store start time
        startTimer();
        MiningService.startMiningService();
        WidgetUtils.showSuccess(res.message ?? "Mining started successfully");
      } else {
        WidgetUtils.showSnackbar(res.message ?? "Something went wrong");
      }
    }, retryFunction: startMining);
  }

  Future<void> claimReward() async {
    var payload = {
      "user_id" : Storage.getValue(Constants.userId).toString(),
      "action" : "claim_reward"
    };

    _apiHelper.claimReward(jsonEncode(payload)).futureValue((v){
      var res = StartMiningModel.fromJson(jsonDecode(v));
      if(res.status ?? false) {
        showClaim.value = false;
        rewardShow.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          rewardShow.value = false;
        });
        Storage.removeValue(Constants.miningStartTime);
        MiningService.stopMiningService();
      //  WidgetUtils.showSuccess(res.message ?? "Something went wrong");
        homeDashboard();
      } else  {
        WidgetUtils.showSnackbar(res.message ?? "Something went wrong");
      }
    }, retryFunction: startMining);
  }
  

  @override
  void onClose() {
    animationController.dispose();
    progressIndicator.dispose();
    timer?.cancel();
    super.onClose();
  }
  
  Future showAnimation(BuildContext context) {
    return Get.dialog(
         Center(
          child: Lottie.asset('assets/images/confetti.json',
            onLoaded: (composition) {
              // Close the dialog after the animation ends
              Future.delayed(composition.duration, () {
                if (Get.isDialogOpen ?? false) {
                  Get.back(); // Close the dialog
                }
              });
            },
          ),
        ),
        name: 'loadingDialog',
      );
  }

}
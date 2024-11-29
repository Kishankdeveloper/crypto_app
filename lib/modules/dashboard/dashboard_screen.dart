import 'package:crypto_app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utills/app_colors.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (DashboardController dashboardController){
          return Scaffold(
            body: Obx(() =>
                controller.buildScreens.elementAt(controller.selectedIndex.value)),
            bottomNavigationBar: Obx(() => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: AppColors.white100,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.white70,
                  showUnselectedLabels: true,
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'madaSemiBold',
                      fontSize: 13
                  ),
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'madaSemiBold',
                      fontSize: 13
                  ),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/images/home_unselected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        activeIcon: Image.asset(
                          "assets/images/home_selected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        label: 'Home'
                      /*  label: languages.home,*/
                    ),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/images/task_unselected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        activeIcon: Image.asset(
                          "assets/images/task_selected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        label: 'Task'
                      // label: languages.report,
                    ),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/images/x-coin.png",
                          height: 40,
                          width: 42,
                        ),
                        activeIcon: Image.asset(
                          "assets/images/x-coin.png",
                          height: 40,
                          width: 42,
                        ),
                        label: 'X-Chain'
                      // label: languages.report,
                    ),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/images/cf_unselected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        activeIcon: Image.asset(
                          "assets/images/cf_selected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        label: 'Chain'
                      // label: languages.report,
                    ),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/images/wallet_unselected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        activeIcon: Image.asset(
                          "assets/images/wallet_selected.png",
                          height: 30,
                          width: 42,
                          color: AppColors.primary,
                        ),
                        label: 'Wallet'
                      // label: languages.report,
                    ),
                  ],
                  currentIndex: controller.selectedIndex.value,
                  onTap: controller.onItemTapped,
                ),
            ),
          );
        });
  }

}
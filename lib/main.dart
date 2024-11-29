import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:crypto_app/utills/app_pages.dart';
import 'package:crypto_app/utills/app_theme.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/global_widget/base_widget.dart';
import 'package:crypto_app/utills/notification_service.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/strings.dart';
import 'package:crypto_app/utills/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:reown_appkit/appkit_modal.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme_widget.dart';
import 'network_services/initializer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  // Initialize other services
  await initialize();

  // Local notifications setup
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  //showMiningCompleteNotification();
  // Ensure that all initialization is done before calling runApp
  Initializer.init(() {
    runApp(const MyApp());
  });
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogged = false;
    if (Storage.hasData(Constants.userId)) {
      isLogged = true;
    }

    final themeController = Get.put(ThemeController());

    return ReownAppKitModalTheme(
      isDarkMode: true,
      child: RestartAppWidget(
        child: ScreenUtilInit(
          builder: (_, __) => ValueListenableBuilder<String>(
            valueListenable: locale,
            builder: (BuildContext context, String value, Widget? child) {
              return GetMaterialApp(
                title: Strings.appName,
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: isLogged ? AppPages.logged : AppPages.initial,
                getPages: AppPages.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                // themeMode: themeController.themeMode.value, // Dynamically change the theme
                themeMode: ThemeMode.dark, // permanent dark
                locale: Locale(value),
                initialBinding: InitialBindings(),
                builder: (_, child) => Directionality(
                  textDirection: TextDirection.ltr, // You can switch to TextDirection.rtl if needed
                  child: BaseWidget(
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

ValueNotifier<String> locale = ValueNotifier('en');
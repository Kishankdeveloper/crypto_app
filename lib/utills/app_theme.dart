import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.white20,
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(AppColors.primary),
        fillColor: WidgetStateProperty.all(AppColors.white20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: AppColors.white20, width: 0.2),
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        overlayColor: WidgetStateProperty.all(AppColors.white50),
        mouseCursor: WidgetStateMouseCursor.clickable,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.white20,
        backgroundColor: AppColors.white20,
          titleTextStyle: TextStyle(
              color: AppColors.white80,
              fontFamily: 'madaSemiBold'
          )
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white20,
        surfaceTintColor: AppColors.white20,
      ),
      cardTheme: const CardTheme(
        surfaceTintColor: AppColors.white10,
        color: AppColors.white10,
      ),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              color: AppColors.white100
          ),
          bodyMedium: TextStyle(
              color: AppColors.white80
          ),
          bodyLarge: TextStyle(
              color: AppColors.white80
          )
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(AppColors.white90),
        )
      ),
      tabBarTheme: const TabBarTheme(
          unselectedLabelColor: AppColors.white90,
          labelColor: AppColors.primary
      ),
        popupMenuTheme: const PopupMenuThemeData(
            color: AppColors.white10,
            textStyle: TextStyle(
                color: AppColors.white10
            )
        ),
      dialogTheme: const DialogTheme(
        backgroundColor: AppColors.white10
      ),

    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: AppColors.white10
        ),
        bodyMedium: TextStyle(
          color: AppColors.white10
        ),
        bodyLarge: TextStyle(
          color: AppColors.white10
        )
      ),
      scaffoldBackgroundColor: Colors.black87,
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(AppColors.white100),
        fillColor: WidgetStateProperty.all(AppColors.white50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: AppColors.white50, width: 0.2),
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        overlayColor: WidgetStateProperty.all(AppColors.white100),
        mouseCursor: WidgetStateMouseCursor.clickable,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.white100,
        backgroundColor: AppColors.white100,
        titleTextStyle: TextStyle(
          color: AppColors.white10,
          fontFamily: 'madaSemiBold'
        )
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white100,
        surfaceTintColor: AppColors.white100,
      ),
      cardTheme: const CardTheme(
        surfaceTintColor: AppColors.white100,
        color: AppColors.white100,
      ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(AppColors.white10),
            )
        ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: AppColors.white10,
        labelColor: AppColors.kPrimaryColor,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.white80,
        textStyle: TextStyle(
          color: AppColors.white10
        )
      ),
        dialogTheme: const DialogTheme(
            backgroundColor: AppColors.white80,
        ),
     /* datePickerTheme: DatePickerThemeData(
        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        yearStyle: const TextStyle(
          fontFamily: 'madaSemiBold',
        ),
        headerHelpStyle: const TextStyle(
          fontFamily: 'madaSemiBold',
        ),
        headerHeadlineStyle: const TextStyle(
          fontFamily: 'madaSemiBold',
        ),
        dayStyle: const TextStyle(
          fontFamily: 'madaSemiBold',
        ),
        weekdayStyle: const TextStyle(
          fontFamily: 'madaSemiBold',
        ),
        dividerColor: AppColors.kPrimaryColor,
      )*/
    );
  }
}

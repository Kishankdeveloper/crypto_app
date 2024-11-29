import 'dart:math';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'app_pages.dart';
import 'global_widget/custom_inkwell_widget.dart';

class WidgetUtils{
  static Future showAlertDialogue(BuildContext context, String title) {
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
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the dialog takes only the required height
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white70,
                    fontFamily: 'madaSemiBold',
                    fontSize: w * 0.04,
                  ),
                ),
                SizedBox(height: h*0.02),
                const Divider(height: 1.0, color: AppColors.white40),
                SizedBox(height: h*0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.07),
                        ),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: AppColors.white10,
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.05,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showWarningDialogue(BuildContext context, String title) {
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
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the dialog takes only the required height
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white70,
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
                        onPressed: () => Navigator.pop(context),
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
                            color: AppColors.primary,
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
                          backgroundColor: AppColors.primary,
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

  static Future showLogoutDialogue(BuildContext context, String title) {
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
                          Storage.clearStorage();
                          Get.offNamedUntil(Routes.login, (routes) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.07),
                              side: const BorderSide(
                                  color: AppColors.primary
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
                          backgroundColor: AppColors.primary,
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

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(String title){
    Get.snackbar(
        'Warning',
        title,
        colorText: AppColors.white10,
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.kPrimaryPrimaryLight
    );
  }

  static void showSuccess(String title){
    Get.snackbar(
        'Success',
        title,
        colorText: AppColors.white10,
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.success60
    );
  }

  static String getRandomString(
      int length, {
        bool isNumber = true,
      }) {
    final chars = isNumber ? '1234567890' : 'abcdefghijklmnopqrstuvwxyz';
    final rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(
          rnd.nextInt(
            chars.length,
          ),
        ),
      ),
    );
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      name: 'loadingDialog',
    );
  }

  static bottomSheet(BuildContext context,
      {required Widget content, double? ht}) {
    return Get.bottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black26,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              height: ht,
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Adjust the radius as needed
                  topRight:
                  Radius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              child: content)
        ],
      ),
      // ignoreSafeArea: false,
      // isScrollControlled: true
    );
  }

  static void timePicker(
      Function(String time) onSelectTime, {
        TimeOfDay? initialTime,
      }) {
    showTimePicker(
      context: Get.overlayContext!,
      initialTime: initialTime ??
          TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
    ).then((v) {
      if (v != null) {
        final now = DateTime.now();
        final dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          v.hour,
          v.minute,
        );

        onSelectTime(dateTime.formatedDate(dateFormat: 'hh:mm aa'));
      }
    });
  }

  static void showDialogs(
      String? message, {
        String title = Strings.error,
        bool success = false,
        VoidCallback? onTap,
      }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: AppColors.white10,
        onWillPop: () async {
          Get.back();
          onTap?.call();
          return true;
        },
        title: success ? Strings.success : title,
        content: Text(
          message ?? Strings.somethingWentWrong,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: const TextStyle(
            fontFamily: 'madaSemiBold',
            color: AppColors.kPrimaryColorDark,
            fontSize: 16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
            onTap: () {
              Get.back();
              onTap?.call();
            },
            title: Strings.ok,
            textStyle: const TextStyle(
            fontFamily: 'madaBold',
            color: AppColors.primary,
            fontSize: 18,
          ),
          ),
        ),
      );

  static bool isValidEmail(String input) {
    // Regular expression for email validation
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(input);
  }

  static bool isValidPhoneNumber(String input) {
    // Example of a simple phone number validation (modify as needed)
    // Check for a valid phone number (10 digits)
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  static String? passwordValidator(String value) {
    // Check if the password contains:
    // - At least 1 uppercase letter
    // - At least 1 number
    // - At least 1 special character
    // - Minimum length of 6 characters
    if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{6,}$').hasMatch(value)) {
      return 'Password must be at least 6 characters long, contain 1 capital letter, 1 number, and 1 special character';
    }
    return null; // Return null if the password is valid
  }

  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showSuccess('Code copied to clipboard');
  }

  static void inviteFriend(String appLink, String referralCode) {
    String message = "Join me on this  x-chain app | use my referral code *$referralCode* to sign up.";
    Share.share(message);
  }

  static Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
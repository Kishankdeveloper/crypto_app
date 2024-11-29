import 'package:crypto_app/modules/otp_auth/otp_auth_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utills/app_pages.dart';

class OtpAuthScreen extends GetView<OtpAuthController> {
  const OtpAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        builder: (OtpAuthController otpAuthController){
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: w,
                    height: h,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Enter the OTP sent',
                            style: TextStyle(
                              fontSize: w * 0.08,
                              fontFamily: 'madaSemiBold'
                            ),),
                            Row(
                              children: [
                                Text('to',
                                  style: TextStyle(
                                      fontSize: w * 0.08,
                                      fontFamily: 'madaSemiBold'
                                  ),),
                                SizedBox(width: w * 0.02,),
                                Text('+91 ${controller.phoneNumber}',
                                  style: TextStyle(
                                      fontSize: w * 0.09,
                                      fontFamily: 'madaBold',
                                    color: AppColors.primary
                                  ),),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                otpTextField(context, w, h),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textSpan(),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.05,
                            ),
                            buttonWidget(h, w)
                          ],
                        ),
                      ],
                    ),),
                  ),
                )
            ),
          );
        });
  }
  Widget otpTextField(BuildContext context, var w, var h){
    return  SizedBox(
      child: OTPTextField(
        pinLength: 4,
        fieldWidth: w * 0.18,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * 0.03),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(w * 0.03)
          ),
          contentPadding: EdgeInsets.symmetric(vertical: h * 0.025),
          counter: const SizedBox(),
        ),
        boxDecoration: const BoxDecoration(
            color: Colors.transparent
        ),
        onCompleted: (v){
          controller.otpVal.value = v;
          FocusScope.of(context).unfocus();
          controller.update();
        },
      ),
    );
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          controller.verifyUser();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Verify OTP',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }

  Widget textSpan(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
                () => Visibility(
              visible: controller.showResend.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Did\'nt you received any code ?',
                    style: TextStyle(
                        color: AppColors.white60
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      controller.startTimer();
                      controller.update();
                    },
                    child: const Text('Resend Code',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'madaBold'
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
        Obx(() => Visibility(
            visible: controller.showTimer.value,
            child: Obx(()=>Text('Resend in ${controller.seconds.value} Sec',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white60,
                  fontFamily: 'madaBold'
              ),
            ))
        ))
      ],
    );
  }
}
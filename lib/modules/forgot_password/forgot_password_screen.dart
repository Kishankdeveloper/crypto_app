import 'package:crypto_app/modules/forgot_password/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utills/app_colors.dart';
import '../../utills/app_pages.dart';
import '../../utills/dprint.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        builder: (ForgotPasswordController forgotController){
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: w,
                    height: h,
                    padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Text('Forgot Password ?',
                          style: TextStyle(
                              fontFamily: 'madaBold',
                              fontSize: w * 0.1
                          ),),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Text('Enter registered phone number we will\nsend otp on your registered number.',
                          style: TextStyle(
                              fontFamily: 'madaSemiBold',
                              fontSize: w * 0.04
                          ),),
                        SizedBox(
                          height: h * 0.1,
                        ),
                        IntlPhoneField(
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  fontSize: w * 0.04,
                                  fontFamily: 'madaRegular'
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(w * 0.05),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(w * 0.05),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(w * 0.04),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(w * 0.04),
                                  borderSide: BorderSide(
                                      color: redColor
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(w * 0.04),
                                  borderSide: const BorderSide(
                                      color: redColor
                                  )
                              ),
                              errorStyle: const TextStyle(
                                  fontFamily: 'madaRegular',
                                  color: Colors.red
                              ),
                              counter: const SizedBox.shrink(),
                              fillColor: AppColors.white100,
                              filled: true
                          ),
                          style: TextStyle(
                              fontFamily: 'madaSemiBold',
                              fontSize: w * 0.05
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            dprint(phone.completeNumber);
                            controller.phoneController.text = phone.number;
                          },
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        buttonWidget(h, w)
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          controller.authenticatePhone();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Send OTP',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }

}
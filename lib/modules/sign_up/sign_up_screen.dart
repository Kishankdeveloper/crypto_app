import 'package:crypto_app/modules/sign_up/sign_up_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utills/app_pages.dart';
import '../../utills/dprint.dart';
import '../../utills/global_textfield.dart';
import '../../utills/widget_utils.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        builder: (SignUpController signUpController) {
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: w,
                   // height: h,
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    child: Form(
                      key: controller.signupFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text('Register',
                            style: TextStyle(
                                fontFamily: 'madaBold',
                                fontSize: w * 0.1
                            ),),
                          Text('Fill personal details to register',
                            style: TextStyle(
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.05,
                              color: AppColors.primary
                            ),),
                          SizedBox(
                            height: h * 0.05,
                          ),
                          GlobalTextField(
                            controller: controller.nameController,
                            labelText: 'Name',
                            hintText: 'Enter Name',
                            keyboardType: TextInputType.name,
                            validator: (v) {
                              String pattern = r'^[a-zA-Z\s]+$'; // Regular expression for alphabetic characters and spaces
                              RegExp regExp = RegExp(pattern);

                              if (v == null || v.isEmpty) {
                                return 'Please enter your name';
                              } else if (!regExp.hasMatch(v)) {
                                return 'Name must contain only alphabets';
                              } else if (v.length < 4) {
                                return 'Name must be at least 6 characters long';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: h*0.02,
                          ),
                          IntlPhoneField(
                            decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: AppColors.white60,
                                    fontSize: w * 0.04,
                                    fontFamily: 'madaRegular'
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1
                                  ),
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(w * 0.04),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w * 0.04),
                                    borderSide: const BorderSide(
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
                                filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.017),
                            ),
                            style: TextStyle(
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.05
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              dprint(phone.number);
                              controller.phoneController.text = phone.number;
                            },
                          ),
                          SizedBox(
                            height: h*0.02,
                          ),
                          GlobalTextField(
                            controller: controller.emailController,
                            labelText: 'EmailID',
                            hintText: 'Enter email Id',
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter email Id';
                              }  else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',).hasMatch(v)){
                                return 'Please enter correct email id';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: h*0.02,
                          ),
                          GlobalTextField(
                            controller: controller.passwordController,
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) {
                             WidgetUtils.passwordValidator(v!);
                             return null;
                            },
                          ),
                          SizedBox(
                            height: h*0.02,
                          ),
                          GlobalTextField(
                            controller: controller.confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: 'Enter Confirm Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                               return 'Confirm password';
                              } else if(controller.passwordController.text != v) {
                                return 'password and confirm password are not same';
                              }else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: h*0.02,
                          ),
                          GlobalTextField(
                            controller: controller.referController,
                            labelText: 'Referral Code (optional)',
                            hintText: 'Enter Referral Code',
                            keyboardType: TextInputType.text,
                            validator: (v) {
                            //  String pattern = r'^[0-9]{10}$'; // Regular expression for exactly 10 digits
                           //   RegExp regExp = RegExp(pattern);

                              if (v == null || v.isEmpty) {
                                return 'Please enter Referral Code';
                              } /*else if (!regExp.hasMatch(v)) {
                                return 'Please enter a valid Referral Code';
                              }*/ else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: h*0.03,
                          ),
                          checkBox(w),
                          buttonWidget(h, w),
                          SizedBox(
                            height: h*0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          );
        });
  }

  Widget checkBox(double w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: controller.termsCheck.value,
          onChanged: (val) {
            controller.termsCheck.value = !controller.termsCheck.value;
            controller.update();
          },
          side: const BorderSide(
            color: Colors.black,
          ),
          activeColor: AppColors.white40,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: w * 0.03,
                fontFamily: 'madaSemiBold',
                color: AppColors.white50,
              ),
              children: [
                TextSpan(text: 'I agree to the ',
                    style: TextStyle(
                        fontSize: w * 0.03
                    )),
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                      color: AppColors.primary, // Make clickable text visually distinct
                      decoration: TextDecoration.underline,
                      fontSize: w * 0.035
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Terms and Conditions tap
                      Get.toNamed(Routes.termsPolicy, arguments: 'terms');
                      // Add your navigation or URL opening logic here
                    },
                ),
                TextSpan(text: ' & ',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.035
                  ),),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      fontSize: w * 0.035
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Privacy Policy tap
                      Get.toNamed(Routes.termsPolicy, arguments: 'privacy');
                      // Add your navigation or URL opening logic here
                    },
                ),
                TextSpan(text: ' .',
                    style: TextStyle(
                      fontSize: w * 0.035,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
         controller.registerUser();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Get OTP',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }
}
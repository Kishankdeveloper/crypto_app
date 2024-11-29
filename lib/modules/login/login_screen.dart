import 'package:crypto_app/modules/login/login_controller.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utills/app_pages.dart';
import '../../utills/global_textfield.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: LoginController(),
        builder: (LoginController loginController){
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: w,
                    height: h,
                    padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                    child:  Form(
                      key: controller.loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.05,
                          ),
                          Text('Welcome Back!',
                          style: TextStyle(
                            fontFamily: 'madaBold',
                            fontSize: w * 0.1
                          ),),
                          Text('Login to continue',
                            style: TextStyle(
                                fontFamily: 'madaSemiBold',
                                fontSize: w * 0.05
                            ),),
                          SizedBox(
                            height: h * 0.1,
                          ),
                          /*IntlPhoneField(
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
                              filled: true
                            ),
                            style: TextStyle(
                              fontFamily: 'madaSemiBold',
                              fontSize: w * 0.05
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              dprint(phone.completeNumber);
                            },
                          ),*/
                          GlobalTextField(
                            controller: controller.userIdController,
                            labelText: 'Phone or Email',
                            hintText: 'Enter Email ID / Phone',
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter Email or Phone';
                              } else {
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
                            }
                          ),
                          SizedBox(
                            height: h * 0.04,
                          ),
                          buttonWidget(h, w),
                         // checkBox(w),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.forgotPassword);
                                },
                                child: const Text('Forgot Password?',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontFamily: 'madaSemiBold',
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary
                                ),),
                              ),
                              SizedBox(width: w * 0.03,)
                            ],
                          ),
                          SizedBox(
                            height: h * 0.06,
                          ),
                          /*borderWidget(),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          googleLoginWidget(w),*/
                          SizedBox(
                            height: h * 0.25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account? ',
                                style: TextStyle(
                                  fontFamily: 'madaRegular',
                                ),),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.register);
                                },
                                child: Text('register',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: w * 0.04,
                                      fontFamily: 'madaSemiBold',
                                  ),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          controller.loginUser();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Login',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }

  Widget borderWidget(){
    return Row(
      children: [
        Expanded(
            child: Container(
              color: AppColors.white50,
              height: 0.5,
            )
        ),
        const SizedBox(width: 10,),
        const Text('Or',
          style: TextStyle(
              color: AppColors.white60
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
            child: Container(
              color: AppColors.white50,
              height: 0.5,
            )
        )
      ],
    );
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

  Widget googleLoginWidget(var w){
    return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
         // backgroundColor: AppColors.white10,
        //  surfaceTintColor: AppColors.white10,
          overlayColor: AppColors.white10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.04)
          ),
          minimumSize: const Size(double.infinity, 45)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/google_icon.svg',
            width: 25,
            height: 25,
          ),
          Text(
            '    Login with Google',
            style: TextStyle(
                fontSize: w * 0.05,
                fontFamily: 'madaRegular'
            ),
          ),
        ],
      ),
    );
  }
}
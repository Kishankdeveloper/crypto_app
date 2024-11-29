import 'package:crypto_app/modules/profile/profile_controller.dart';
import 'package:crypto_app/utills/global_textfield.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utills/app_colors.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        builder: (ProfileController profileController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile',
              style: TextStyle(
                fontSize: w * 0.05,
                fontFamily: 'madaRegular'
              ),),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal : h * 0.02),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.04,
                      ),
                      GlobalTextField(
                          controller: controller.userNameController,
                          labelText: 'Username',
                        hintText: 'Enter username',
                        readOnly: true,
                        validator: (v) {
                            if(v == null || v.isEmpty) {
                              return 'Please enter userName';
                            }
                            return null;
                        },
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      GlobalTextField(
                        controller: controller.mobileController,
                        labelText: 'Phone',
                        hintText: 'Enter Phone Number',
                        readOnly: true,
                        validator: (v) {
                          if(v == null || v.isEmpty) {
                            return 'Please enter phone number';
                          } else {
                            WidgetUtils.isValidPhoneNumber(v);
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      GlobalTextField(
                        controller: controller.emailController,
                        labelText: 'Email',
                        hintText: 'Enter Email ID',
                        readOnly: true,
                        validator: (v) {
                          if(v == null || v.isEmpty) {
                            return 'Please enter Email';
                          } else {
                            WidgetUtils.isValidEmail(v);
                          }
                          return null;
                        },
                      ),
                     /* SizedBox(
                        height: h * 0.02,
                      ),
                      GlobalTextField(
                        controller: controller.userIDController,
                        readOnly: true,
                        labelText: 'User ID',
                        hintText: 'Enter User ID',
                        validator: (v) {
                          if(v == null || v.isEmpty) {
                            return 'Please enter user Id';
                          }
                          return null;
                        },
                      ),*/
                      SizedBox(
                        height: h * 0.04,
                      ),
                      //buttonWidget(h, w)
                    ],
                  ),
                ),
              ),
            ),
          );
    });
  }
  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
          Get.back();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.065)
        ),
        child: Text('Update Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }
}
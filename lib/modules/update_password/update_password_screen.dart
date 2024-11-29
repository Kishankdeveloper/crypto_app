import 'package:crypto_app/modules/update_password/update_password_controller.dart';
import 'package:crypto_app/utills/global_textfield.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utills/app_colors.dart';

class UpdatePasswordScreen extends GetView<UpdatePasswordController> {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(builder: (UpdatePasswordController updatePasswordController) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Update Password',
          style: TextStyle(
            fontFamily: 'madaRegular',
            fontSize: w * 0.05
          ),),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: w,
                height: h,
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.03,
                      ),
                      Image.asset('assets/images/reset-password.png', width: w * 0.4, fit: BoxFit.cover,),
                     /* SizedBox(
                        height: h * 0.04,
                      ),
                      GlobalTextField(
                          controller: controller.previousPasswordController,
                          labelText: 'Previous Password',
                        hintText: 'Enter previous password',
                        validator: (v) {
                          WidgetUtils.passwordValidator(v!);
                          return null;
                        },
                      ),*/
                      SizedBox(
                        height: h * 0.03,
                      ),
                      GlobalTextField(
                        controller: controller.newPasswordController,
                        labelText: 'New Password',
                        hintText: 'Enter new password',
                        validator: (v) {
                          WidgetUtils.passwordValidator(v!);
                          return null;
                        },
                      ),
                      SizedBox(
                        height: h * 0.03,
                      ),
                      GlobalTextField(
                        controller: controller.confirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Enter Confirm Password',
                        keyboardType: TextInputType.visiblePassword,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Confirm password';
                          } else if(controller.newPasswordController.text != v) {
                            return 'password and confirm password are not same';
                          }else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: h * 0.04,
                      ),
                      buttonWidget(h, w)
                    ],
                  ),
                ),
              ),
            )
        ),
      );
    }
    );
  }
  Widget buttonWidget(var h, var w) {
    return ElevatedButton(
        onPressed: (){
         controller.updatePass();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04)
            ),
            minimumSize: Size(w, h * 0.07)
        ),
        child: Text('Change Password',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontFamily: 'madaSemiBold'
          ),));
  }
}
import 'dart:convert';

import 'package:crypto_app/network_services/api_helper.dart';
import 'package:crypto_app/network_services/models/register_model.dart';
import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/dprint.dart';
import 'package:crypto_app/utills/extensions.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utills/app_pages.dart';

class SignUpController extends GetxController {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final referController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ApiHelper _apiHelper = ApiHelper.to;

  final signupFormKey = GlobalKey<FormState>();

  RxBool termsCheck = false.obs;

// use below code if date picker need. //
 /* void pickDate(BuildContext context) async{
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    update;
  }*/

 // check validation
 Future<void> registerUser() async {

   if(!termsCheck.value){
    return WidgetUtils.showSnackbar('Agree to terms and conditions');
   }
   if(signupFormKey.currentState!.validate()){
     // call register api
     var payload = {
       "name": nameController.text,
       "mobile_no": phoneController.text,
       "email": emailController.text,
       "password": passwordController.text,
       "referral_code": referController.text
     };

     _apiHelper.register(jsonEncode(payload)).futureValue(((v){
       var res = RegisterModel.fromJson(jsonDecode(v));
       if(res.status ?? false) {
         Storage.clearStorage();
         Storage.saveValue(Constants.userId, res.data?.userId.toString());
         Get.toNamed(Routes.otp, arguments: {
           "phone" : phoneController.text,
           "type" : "register"
         });
       }else{
         WidgetUtils.showSnackbar(res.message ?? 'something went wrong');
       }
     }), retryFunction: registerUser);
   } else {
     // validation fail
   }
 }
}
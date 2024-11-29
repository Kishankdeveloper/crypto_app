import 'package:crypto_app/utills/constants.dart';
import 'package:crypto_app/utills/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  final userNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final userIDController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> getLocalData() async {
    userNameController.text = '${Storage.getValue(Constants.userName)}';
    mobileController.text = '${Storage.getValue(Constants.mobile)}';
    emailController.text = '${Storage.getValue(Constants.email)}';
    userIDController.text = '${Storage.getValue(Constants.userId)}';
  }

  @override
  void onInit() {
    getLocalData();
    super.onInit();
  }
}
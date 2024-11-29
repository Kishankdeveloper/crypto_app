import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;

  const CustomErrorWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          message ?? 'something went wrong!',
          style: Get.textTheme.headlineSmall,
        ),
      ),
    );
  }
}

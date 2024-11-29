import 'package:crypto_app/modules/terms_policy/terms_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsPolicyScreen extends GetView<TermsPolicyController> {
  const TermsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(builder: (TermsPolicyController termsPolicyController) {
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.type.value == 'terms' ? 'Terms and Conditions' : 'Privacy Policy',
          style: TextStyle(
            fontFamily: 'madaSemiBold',
            fontSize: w * 0.05
          ),),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(controller.content,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: w * 0.04,
                fontFamily: 'madaSemiBold'
              ),),
            ),
          ),
        ),
      );
    });
  }

}
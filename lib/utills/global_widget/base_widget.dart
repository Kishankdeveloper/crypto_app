import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../network_services/api_interface_controller.dart';
import 'custom_retry_widget.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiInterfaceController>(
      builder: (c) => Stack(
        children: [
          Positioned.fill(
            child: child,
          ),
          Visibility(
            visible: c.retry != null && c.error != null,
            child: Positioned.fill(
              child: Scaffold(
                body: CustomRetryWidget(
                  onPressed: c.onRetryTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



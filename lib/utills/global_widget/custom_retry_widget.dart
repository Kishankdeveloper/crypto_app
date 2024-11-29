import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRetryWidget extends StatelessWidget {
  final String error;
  final VoidCallback onPressed;

  const CustomRetryWidget({
    super.key,
    required this.onPressed,
    this.error = 'Something went wrong',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error),
          SizedBox(height: 16.h),
          TextButton(
              onPressed: onPressed,
              child: const Text('Retry')
          )
        ],
      ),
    );
  }
}

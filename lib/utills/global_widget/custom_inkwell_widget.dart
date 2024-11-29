import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_colors.dart';


class CustomInkwellWidget extends Material {
  CustomInkwellWidget({
    super.key,
    required Function() onTap,
    required Widget child,
  }) : super(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: AppColors.kPrimaryColor.withOpacity(0.24),
            child: child.paddingAll(8),
          ),
        );

  CustomInkwellWidget.text({
    super.key,
    required Function() onTap,
    required String title,
    TextStyle? textStyle,
    Color? textColor,
    double? textSize,
  })  : assert(
          textColor == null || textStyle == null,
          'Cannot provide both a textColor and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(color: color)".',
        ),
        assert(
          textSize == null || textStyle == null,
          'Cannot provide both a textSize and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(size: textSize)".',
        ),
        super(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Text(
              title,
            ).paddingAll(8),
          ),
        );
}

import 'dart:developer';
import 'package:crypto_app/utills/storage.dart';
import 'package:crypto_app/utills/strings.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../network_services/api_error.dart';
import '../network_services/api_interface_controller.dart';
import '../network_services/api_response.dart';
import 'app_pages.dart';
import 'constants.dart';
import 'dprint.dart';
import 'loading_dialog.dart';

abstract class Extensions {}

extension HexColorExt on String {
  Color get fromHex {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) {
      buffer.write('ff');
    }

    if (startsWith('#')) {
      buffer.write(replaceFirst('#', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension DateTimeFormatterExt on DateTime {
  String formatedDate({
    String dateFormat = 'yyyy-MM-dd',
  }) {
    final formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }
}

extension TimeOfDayExt on String {
  TimeOfDay getTimeOfDay({
    int addMinutes = 0,
  }) =>
      TimeOfDay.fromDateTime(
        DateFormat.jm().parse(this).add(
          Duration(
            minutes: addMinutes,
          ),
        ),
      );
}

extension ImageExt on String {
  String get image => 'assets/images/$this.png';

  Image imageAsset({
    Size? size,
    BoxFit? fit,
    Color? color,
  }) =>
      Image.asset(
        this,
        color: color,
        width: size?.width,
        height: size?.height,
        fit: fit,
      );
}

extension FutureExt<T> on Future<Response<T>?> {
  void futureValue(
      Function(T value) response, {
        Function(String? error)? onError,
        required VoidCallback retryFunction,
        bool showLoading = true,
      }) {
    final interface = Get.find<ApiInterfaceController>();
    interface.error = null;

    if (showLoading) LoadingDialog.showLoadingDialog();

    timeout(
      Constants.timeout,
      onTimeout: () {
        LoadingDialog.closeLoadingDialog();
        WidgetUtils.showSnackbar(Strings.connectionTimeout);
        _retry(interface, retryFunction);

        throw const ApiError(
          type: ErrorType.connectTimeout,
          error: Strings.connectionTimeout,
        );
      },
    ).then((value) {
      dprint('${value?.body}');
      LoadingDialog.closeLoadingDialog();

      if (value?.body != null) {
        final result = ApiResponse.getResponse<T>(value!);
        if (result != null) {
          response(result);
        }
      }

      interface.update();
    }).catchError((e, stack) {
      LoadingDialog.closeLoadingDialog();

      log(e.toString(), stackTrace: stack);

      if (e == null) return;

      final String errorMessage = e is ApiError ? e.message : e.toString();

      if (e is ApiError) {
        if ((e.type == ErrorType.connectTimeout || e.type == ErrorType.noConnection)) {
          interface.error = e;

          _retry(interface, retryFunction);
        } else {
          WidgetUtils.showDialogs(
            errorMessage,
            onTap: errorMessage != Strings.unauthorize
                ? null
                : () {
              Storage.clearStorage();Get.offAllNamed(Routes.login,);
            },
          );
        }
      }

      if (onError != null) {
        onError(errorMessage);
      }

      printError(info: 'catchError: error: $e\nerrorMessage: $errorMessage');
    });
  }

  void _retry(
      ApiInterfaceController interface,
      VoidCallback retryFunction,
      ) {
    interface.retry = retryFunction;
    interface.update();
  }
}

extension AlignWidgetExt on Widget {
  Widget align({
    Alignment alignment = Alignment.center,
  }) =>
      Align(
        alignment: alignment,
        child: this,
      );
}

extension FormatDurationExt on int {
  String formatDuration() {
    final min = this ~/ 60;
    final sec = this % 60;
    return "${min.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")} min";
  }
}

extension DebugLog on String {
  void debugLog() {
    return debugPrint(
      '\n******************************* DebugLog *******************************\n'
          ' $this'
          '\n******************************* DebugLog *******************************\n',
      wrapWidth: 1024,
    );
  }
}

extension ListExtensions<T> on List<T> {
  List<T> takeLast(int count) {
    return length > count ? sublist(length - count) : this;
  }
}

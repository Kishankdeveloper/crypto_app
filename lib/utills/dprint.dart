import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

dprint(str) {
  var logger = Logger();
  if (kDebugMode) {
    logger.d(str.toString());
  }
}

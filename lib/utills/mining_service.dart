import 'package:flutter/services.dart';

class MiningService {
  static const platform = MethodChannel('com.kishan.crypto.crypto_app/mining');

  static Future<void> startMiningService() async {
    try {
      await platform.invokeMethod('startMining');
    } on PlatformException catch (e) {
      print("Error starting mining service: ${e.message}");
    }
  }

  static Future<void> stopMiningService() async {
    try {
      await platform.invokeMethod('stopMining');
    } on PlatformException catch (e) {
      print("Error stopping mining service: ${e.message}");
    }
  }
}

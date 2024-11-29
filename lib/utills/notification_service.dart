import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> showMiningCompleteNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'mining_complete_channel',
    'Mining Completion',
    channelDescription: 'Notification channel for mining completion',
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Mining Complete',
    'Your mining session is complete! Claim your reward.',
    platformChannelSpecifics,
    payload: 'mining_complete',
  );
}

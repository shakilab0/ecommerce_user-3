import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //static final NotificationService _service = NotificationService._internal();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //NotificationService._internal();

  /*factory NotificationService() {
    return _service;
  }*/

  NotificationService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_notifications');
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  Future<void> sendNotifications(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails('channel01', 'promo code',
        channelDescription: 'Sends promo code for discount',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, message.notification!.title, message.notification!.body, notificationDetails,
        payload: 'item x');
  }
}
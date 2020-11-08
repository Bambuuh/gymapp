import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;
InitializationSettings initializationSettings;

class Notifications {
  static final _restingId = 'resting_notifications';
  static final _restingChannelName = 'Resting Notifications';
  static final _restingDescription = 'notifications for when resting is complete';

  static Future<bool> init() async {
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: null);
    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    return await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null);
  }

  static sendNotification(String title, String body) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _restingId,
      _restingChannelName,
      _restingDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static scheduleNotification(int seconds, String title, String body) async {
    final id = DateTime.now().millisecond;
    print(id);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _restingId,
          _restingChannelName,
          _restingDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    return id;
  }

  static cancelNotification(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }
}

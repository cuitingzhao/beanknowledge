import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

Future<void> initNotification(
    //Initialize for Android
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  //Initialize for iOS
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  //Put them together to initialize
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
}

// Define which page to push when clicking the notification
Future selectNotification(String payload) async {
  //We leave it empty for now as we don't have many pages
}

//This is only for iOS permission request as Android doesn't require this step
void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  //The above
}

//This is to set the timezone used by the app
//All of the functions used (such as initializeTimeZones) are from timezone/data/latest package
Future<void> configureLocalTimeZone() async {
  initializeTimeZones();
  var shanghai = getLocation(
      'Asia/Shanghai'); //The full list is referred to Olsen time zone ID
  setLocalLocation(shanghai);
}

//This is the function to set what time to send the local notification
Future<void> scheduleDaily7PMNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '豆知识', //Title
      '花费一分钟学点新知识吧', //Content
      _nextInstanceOfSevenPM(), //
      const NotificationDetails(
        android: null,
        iOS: null,
      ),
      // Decide if show the notification in low-power mode
      androidAllowWhileIdle: true,
      //This is only for iOS
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

// This is to be used by schedule time function
TZDateTime _nextInstanceOfSevenPM() {
  final TZDateTime now = TZDateTime.now(local);
  TZDateTime scheduledDate =
      TZDateTime(local, now.year, now.month, now.day, 20);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

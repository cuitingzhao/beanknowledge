import 'package:beanknowledge/config/router_config.dart';
import 'package:beanknowledge/src/ui/today_content_page.dart';
import 'package:beanknowledge/util/color_helper.dart';
import 'package:beanknowledge/util/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Start initializing the notification function
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await configureLocalTimeZone(); //set up local timezone
  await initNotification(
      flutterLocalNotificationsPlugin); //initialize local notification plugin
  requestIOSPermissions(
      flutterLocalNotificationsPlugin); // only for IOS, as Android doesn't require permission request
  //End initializing the notification function

  //Schedule notification time
  scheduleDaily7PMNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Prevent screen from rotating
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
        designSize:
            Size(750, 1334), // The side of the device in the design draft
        allowFontScaling:
            false, // Prevent font auto scalling with the system setting
        child: MaterialApp(
            initialRoute: '/',
            onGenerateRoute:
                onGenerateRoute, // This is the function defined in the router_config file
            home: TodayContentPage(),
            // Define some themes to be reused  across different pages
            theme: ThemeData(
                fontFamily: 'Roboto',
                textTheme: TextTheme(
                  headline1:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w900)
                          .apply(color: ColorHelper.fromHex('205072')),
                  headline2:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800)
                          .apply(color: ColorHelper.fromHex('205072')),
                  bodyText1:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700)
                          .apply(
                    color: ColorHelper.fromHex('205072'),
                  ),
                  bodyText2:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)
                          .apply(
                    color: ColorHelper.fromHex('205072'),
                  ),
                ))));
  }
}

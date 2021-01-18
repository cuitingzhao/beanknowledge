import 'package:beanknowledge/config/router_config.dart';
import 'package:beanknowledge/util/color_helper.dart';
import 'package:beanknowledge/util/notification_helper.dart';
import 'package:beanknowledge/util/storage_helper.dart';
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
  bool _firstLaunch = await checkFirstLaunch();

  runApp(MyApp(
    firstLaunch: _firstLaunch,
  ));
}

Future<bool> checkFirstLaunch() async {
  //firstLaunch in sharedPreference can only be false or null, not other values
  bool _firstLaunch = await StorageHelper.getBool('firstlaunch') ?? true;
  print('[checkFirstLaunch] firstLaunch is $_firstLaunch');
  if (_firstLaunch) {
    StorageHelper.setBool('firstlaunch', false);
    return true;
  } else {
    return false;
  }
}

String getInitialRoute(bool firstLaunch) {
  if (firstLaunch) {
    return '/firstLaunch';
  } else {
    return '/content';
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key, @required this.firstLaunch}) : super(key: key);
  final bool firstLaunch;
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
            initialRoute: getInitialRoute(widget.firstLaunch),
            onGenerateRoute:
                onGenerateRoute, // This is the function defined in the router_config file
            // home: TodayContentPage(),
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

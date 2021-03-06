import 'package:beanknowledge/src/ui/first_launch_page.dart';
import 'package:beanknowledge/src/ui/today_content_page.dart';
import 'package:flutter/material.dart';

final routeList = {
  '/content': (context) => TodayContentPage(),
  '/firstLaunch': (context) => FirstLaunchPage()
};

//固定写法，用来处理路由
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routeList[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

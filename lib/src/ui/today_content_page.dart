import 'package:beanknowledge/src/ui/header_1.dart';
import 'package:beanknowledge/src/ui/today_content_body.dart';
import 'package:flutter/material.dart';

class TodayContentPage extends StatefulWidget {
  TodayContentPage({Key key}) : super(key: key);

  @override
  _TodayContentPageState createState() => _TodayContentPageState();
}

class _TodayContentPageState extends State<TodayContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Header1(headerText: '今日豆知识'),
            TodayContentBody(),
          ],
        ));
  }
}

import 'package:beanknowledge/src/models/main_content.dart';
import 'package:beanknowledge/src/services/content_provider.dart';
import 'package:beanknowledge/src/ui/header_1.dart';
import 'package:beanknowledge/src/ui/today_content_body.dart';
import 'package:flutter/material.dart';

class TodayContentPage extends StatefulWidget {
  TodayContentPage({Key key}) : super(key: key);

  @override
  _TodayContentPageState createState() => _TodayContentPageState();
}

class _TodayContentPageState extends State<TodayContentPage> {
  //The content provider is used to get data from server
  ContentProvider contentProvider = ContentProvider();
  List<MainContent> _contentList = [];

  @override
  void initState() {
    //Whenever override initState function, you should call super.initState() first
    super.initState();
    //Call the content provider to fetch the data when the app starts
    contentProvider.fetchContentToday().then((contentList) {
      setState(() {
        _contentList = contentList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  Header1(headerText: '今日豆知识'),
                  TodayContentBody(contentList: _contentList),
                ],
              )),
        ),
        onRefresh: () async {
          //Reload the data when user pull to refresh
          await contentProvider.fetchContentToday().then((contentList) {
            setState(() {
              _contentList = contentList;
            });
          });
        });
  }
}

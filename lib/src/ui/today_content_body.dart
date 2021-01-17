import 'package:beanknowledge/src/models/main_content.dart';
import 'package:beanknowledge/src/services/content_provider.dart';
import 'package:beanknowledge/util/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class TodayContentBody extends StatefulWidget {
  TodayContentBody({Key key}) : super(key: key);

  @override
  _TodayContentBodyState createState() => _TodayContentBodyState();
}

class _TodayContentBodyState extends State<TodayContentBody> {
  //As we have multiple contents to show in multiple pages,
  //this variable is used to record content on current page
  //so that to share the content
  int _pageIndex = 0;
  //This list is used to store the content received from server
  List<MainContent> _contentList = [];
  //The content provider is used to get data from server
  ContentProvider contentProvider = ContentProvider();

  @override
  void initState() {
    //Whenever you override initState function, you should call super.initState() first
    super.initState();
    //Call the content provider to fetch the data when the app starts
    contentProvider.fetchContentToday().then((contentList) {
      setState(() {
        _contentList = contentList;
      });
    });
  }

  Widget build(BuildContext context) {
    // As we defined previously in content provider class,
    // if there is exception occured, content provider will return null
    if (_contentList == null) {
      return Container(
        height: ScreenUtil().setHeight(800),
        alignment: Alignment.center,
        child: Text('很抱歉读取内容失败，请稍后再试',
            style: Theme.of(context).textTheme.bodyText1),
      );
    } else {
      // if there is no exception, it means we receive response from server properly
      // even though the response might be empty, so we have to decide how to handle such case
      return _contentList.isEmpty
          ? CircularProgressIndicator() // if it is empty, we will return a rolling "loading" icon
          : RefreshIndicator(
              // otherwise, we return the normal content page
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30)),
                    child: AspectRatio(
                      aspectRatio: 3 / 5,
                      child: Swiper(
                          loop: false,
                          itemCount: _contentList
                              .length, // Defines how many pages to show
                          pagination: SwiperPagination(
                            // Customize pagination style
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.grey,
                                size: ScreenUtil().setSp(10),
                                activeSize: ScreenUtil().setSp(15),
                                activeColor: ColorHelper.fromHex('205072')),
                          ),
                          onIndexChanged: (index) {
                            //When the index change, record the change into _pageIndex variable
                            this._pageIndex = index;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            String title = _contentList[index].title;
                            String content = _contentList[index].content;
                            String link = _contentList[index].link;
                            return Container(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(50)),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20),
                                    left: ScreenUtil().setWidth(20),
                                    right: ScreenUtil().setWidth(20),
                                    bottom: ScreenUtil().setHeight(10)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: ColorHelper.fromHex('FEFEFA'),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                                          blurRadius: 3, //阴影模糊程度
                                          spreadRadius: 8 //阴影扩散程度
                                          )
                                    ]),
                                child: Stack(
                                  children: [
                                    //title
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: titleWidget(title)),

                                    // content
                                    Align(
                                      alignment: Alignment.center,
                                      child: contentWidget(content),
                                    ),

                                    // Share button
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            shareButton(_contentList),
                                            hyperContentWidget(link),
                                          ],
                                        )),
                                  ],
                                ));
                          }),
                    ),
                  )
                ],
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

  // This function returns the title widget
  Widget titleWidget(String title) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setHeight(20)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  // This function returns the content widget
  Widget contentWidget(String content) {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  // This function returns the "check details" widget
  Widget hyperContentWidget(String url) {
    print('url is $url');
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        primary: ColorHelper.fromHex('329D9C'),
      ),
      child: Text('查看出处',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(30),
            decoration: TextDecoration.underline,
          )),
      onPressed: () => launchURL(url),
    );
  }

  //Use usr_launcher package to redirect the hyperlink
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //This function returns the share button widget
  Widget shareButton(List<MainContent> mainContentList) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        primary: ColorHelper.fromHex('7BE495'),
      ),
      child: Text('告诉别人',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(30),
            //decoration: TextDecoration.underline,
          )),
      onPressed: () async {
        print('pageIndex is $_pageIndex');
        final RenderBox box = context.findRenderObject();
        await Share.share(
            mainContentList[_pageIndex].content.toString() +
                ' -- 下载豆知识，每天一分钟学点新知识',
            subject: '豆知识',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      },
    );
  }
}

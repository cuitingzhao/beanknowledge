import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header1 extends StatelessWidget {
  final String headerText;
  const Header1({Key key, @required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(120),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(100),
                  ))),
          Align(
              alignment: Alignment.center,
              child: Text(
                '$headerText',
                style: Theme.of(context).textTheme.headline1,
              ))
        ],
      ),
    );
  }
}

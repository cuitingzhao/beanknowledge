import 'package:beanknowledge/config/text_config.dart';
import 'package:beanknowledge/util/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstLaunchPage extends StatelessWidget {
  const FirstLaunchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/firstlaunch.png'),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(80),
                  bottom: ScreenUtil().setHeight(80)),
              child: Text('豆知识',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: ColorHelper.fromHex('7BE495')))),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(400),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
            child: Text(TextConfig.launchText,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.fromHex('7BE495'))),
          ),
          Center(
              child: ElevatedButton(
            child: Text('开始吧',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/content');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(80),
                  right: ScreenUtil().setWidth(80)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              primary: ColorHelper.fromHex('329D9C'),
            ),
          ))
        ],
      ),
    );
  }

  // Widget getFirstLaunchPage() {
  //   return
  // }
}

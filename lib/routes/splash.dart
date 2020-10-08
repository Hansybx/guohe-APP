import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/common/routeStr.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // 判断是否是大屏幕
  bool isLargeScreen;

  bool flag;
  String uid;
  String passwd;

  Future<void> get() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    flag = pref.getBool(LocalShare.IS_LOGIN);
    if (flag != null && flag == true) {
      uid = pref.getString(LocalShare.STU_ID);
      passwd = pref.getString(LocalShare.STU_PASSWD);
      getCalendar(uid, passwd);
    }
  }

  // 延时跳转
  jumpPage() {
    return Timer(Duration(milliseconds: 500), () {
      get().then((value) {
        if (flag != null && flag == true) {
          Navigator.pushReplacementNamed(context, RouteStr.HOME);
        } else {
          Navigator.pushReplacementNamed(context, RouteStr.LOGIN);
        }
      });
    });
  }

  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
    _initLocale();
    Future.delayed(new Duration(milliseconds: 500));
  }

  Future<void> getCalendar(uid, passwd) async {
    if (uid != null) {
      FormData formData = FormData.fromMap({
        "username": uid,
        "password": passwd,
      });
      await Dio().post(Constant.CALENDAR, data: formData).then((res) {
        List<String> temp = List<String>.from(res.data['info']['allYear']);
        SpUtil.putStringList(LocalShare.ALL_YEAR, temp);
        SpUtil.putString(LocalShare.SEMESTER, temp[0]);
        SpUtil.putInt(LocalShare.SERVER_WEEK, res.data['info']['weekNum']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    jumpPage();
    _initAsync();
  }

  // 初始化语言
  Future<void> _initLocale() {
    String language = SpUtil.getString(LocalShare.LANGUAGE);
    setState(() {
      if (language == "简体中文") S.load(Locale('zn', 'CN'));
      if (language == "English") S.load(Locale('en', 'US'));
    });
  }

  @override
  Widget build(BuildContext context) {
    //判断屏幕宽度
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return Container(
        child: isLargeScreen
            ? Container(
                color: Colors.white,
                child: Center(child: Container(width: 600, child: splashImg())))
            : splashImg());
  }

  Widget splashImg() {
    return Image(
      image: AssetImage('assets/imgs/splash.png'),
      fit: BoxFit.fill,
    );
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool flag;
  var uid;
  var passwd;

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
    print("default language:" + language);
//    print("default language:" + _locale.languageCode);
    setState(() {
      if (language == "简体中文") S.load(Locale('zn', 'CN'));
      if (language == "English") S.load(Locale('en', 'US'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        color: Colors.white,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.lightBlueAccent]),
            ),
            child: Center(
                child: Image(
                  image: AssetImage('assets/imgs/logo.png'),
                  width: 150,
                  height: 150,
                ))
        ));
  }
}

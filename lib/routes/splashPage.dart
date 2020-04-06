import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
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

    print('splash');
  }

  // 延时跳转
  jumpPage() {
    return Timer(Duration(milliseconds: 500), () {
      get().then((value) {
        if (flag != null && flag == true) {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
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

  //version info
  void localVersion(){
   var version = SpUtil.getString(LocalShare.VERSION);
    if(version.length == 0){
      Dio().get(Constant.VERSION).then((value){
        if(value.statusCode == 200){
          SpUtil.putString(LocalShare.VERSION, value.data['info'][0]['version']);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    jumpPage();
    _initAsync();
    localVersion();
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
              image: AssetImage('assets/imgs/guohe_logo.jpg'),
              width: 150,
              height: 150,
            ))));
  }
}

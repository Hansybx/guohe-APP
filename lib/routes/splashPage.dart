import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
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
    if (flag!=null && flag == true){
      uid = pref.getString(LocalShare.STU_ID);
      passwd = pref.getString(LocalShare.STU_PASSWD);
      getCalendar(uid,passwd);
    }

    print('splash');
  }

  Future<void> getOneContent() async {
    await Dio().post(Constant.ONE).then((res) {
      LocalShare.DATE = res.data['data']['post_date']
          .toString()
          .split(" ")[0]
          .replaceAll("-", "/");
      LocalShare.IMG_URL = res.data['data']['img_url'];
      LocalShare.IMG_AUTHOR = res.data['data']['pic_info'];
      LocalShare.IMG_KIND = res.data['data']['title'];
      LocalShare.WORD = res.data['data']['forward'];
      LocalShare.WORD_FROM = res.data['data']['words_info'];
    });
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

  Future<void> getCalendar(uid,passwd) async {
    if (uid != null) {
      FormData formData = FormData.fromMap({
        "username": uid,
        "password": passwd,
      });
      await Dio().post(Constant.CALENDAR,data: formData).then((res) {
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
    getOneContent();
    _initAsync();
//    getCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.white,
      child: Text("test"),
    );
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
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
  Future<void> get()  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    flag = pref.getBool(LocalShare.IS_LOGIN);
//    setState(() {
//    LocalShare.loginFlag = flag;
//    });
    print('splash');
  }

  Future<void> getOneContent() async {
    await Dio().post(Constant.ONE).then((res) {
        LocalShare.DATE = res.data['data']['post_date'].toString().split(" ")[0].replaceAll("-", "/");
        LocalShare.IMG_URL = res.data['data']['img_url'];
        LocalShare.IMG_AUTHOR = res.data['data']['pic_info'];
        LocalShare.IMG_KIND = res.data['data']['title'];
        LocalShare.WORD = res.data['data']['forward'];
        LocalShare.WORD_FROM = res.data['data']['words_info'];
    });
  }



  // 延时跳转
  jumpPage() {
    return Timer(Duration(milliseconds: 100), () {
      get().then((value) {
        if(flag != null && flag == true){
          Navigator.pushReplacementNamed(context, '/main');
        }else{
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }


  @ override
  void initState()  {
    super.initState();
    jumpPage();
    getOneContent();
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

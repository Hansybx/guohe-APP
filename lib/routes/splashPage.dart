import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool flag;
  Future<void> get()  async {
    print('1');
    SharedPreferences pref = await SharedPreferences.getInstance();
    flag = pref.getBool(LocalShare.IS_LOGIN);
//    setState(() {
//    LocalShare.loginFlag = flag;
//    });
    print('splash');
  }

  // 延时跳转
  jumpPage() {
    return Timer(Duration(milliseconds: 100), () {
      get().then((value) {
        print('2');
        print('flag');
        print(flag);
        print(LocalShare.loginFlag);
        print('2');
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

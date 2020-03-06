import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_app/routes/myPage/one.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String version='1.0.0';

//  登出时清空本机缓存
  Future<void> clean() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    print('cleared');
  }

  void logout() {
    clean();
    Navigator.pushReplacementNamed(context, '/login');
  }

  //版本信息
  void localVersion(){
    version = SpUtil.getString(LocalShare.VERSION);
  }


  @override
  void initState() {
//    print(LocalShare.VERSION);
//    versionGet();
    localVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "我",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
//              One(),
              ListTile(
                title: new Text("版本"),
                subtitle: Text(version),
                onTap: ()=>Share.share('check out my website https://example.com', subject: 'Look what I made!'),
                leading: Icon(AntDesign.form),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),

              SizedBox(
                height: 20,
              ),
              ListTile(
                title: new Text("反馈"),
                leading: Icon(AntDesign.form),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // do something
                  Navigator.pushNamed(context, '/feedback');
                },
              ),
              ListTile(
                title: new Text("切换账号"),
                leading: Icon(AntDesign.reload1),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => logout(),
              ),
            ],
          ),
        ));
  }
}

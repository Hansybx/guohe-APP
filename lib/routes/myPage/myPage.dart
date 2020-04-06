import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String version = '1.0.0';
  String name = "Unknown";
  String id = "Unknown";

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
  void localVersion() {
    version = SpUtil.getString(LocalShare.VERSION);
  }

  void getStuInfo(){
    name=SpUtil.getStringList(LocalShare.STU_INFO)[0];
    id = SpUtil.getString(LocalShare.STU_ID);
  }

  @override
  void initState() {
//    print(LocalShare.VERSION);
//    versionGet();
    localVersion();
    getStuInfo();
    UmengAnalyticsPlugin.pageStart("myPage");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "我的果核",
            style: new TextStyle(color: Colors.black87),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Text("  Hi!",style: TextStyle(fontSize: 60),),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text(id),
                              Text(name)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
//              One(),
              ListTile(
                title: new Text("关于果核"),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
                leading: Icon(AntDesign.notification),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),

              ListTile(
                title: new Text("分享"),
                onTap: () => Share.share('果核', subject: 'Look what I made!'),
                leading: Icon(AntDesign.sharealt),
                trailing: Icon(Icons.keyboard_arrow_right),
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

              ListTile(
                  title: new Text("设置"),
                  leading: Icon(AntDesign.setting),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => {}),

              ListTile(
                title: new Text("检查更新"),
                subtitle: Text("当前版本:" + version),
                leading: Icon(AntDesign.info),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ));
  }
}

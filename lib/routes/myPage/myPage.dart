import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/common/string_file.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String avatar = '';
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

  void getStuInfo() {
    name = SpUtil.getStringList(LocalShare.STU_INFO)[0];
    id = SpUtil.getString(LocalShare.STU_ID);
    avatar = SpUtil.getString(LocalShare.AVATAR);
  }

  @override
  void initState() {
//    print(LocalShare.VERSION);
//    versionGet();
    localVersion();
    getStuInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "我的果核",
            style: new TextStyle(color: Colors.black87),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyInfo(),
              new SizedBox(height: 15),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("关于果核"),
                  onTap: () {
                    Navigator.pushNamed(context, RouteStr.ABOUT);
                  },
                  leading: Icon(AntDesign.notification, color: Colors.orange),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              new SizedBox(height: 15),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("反馈"),
                  leading: Icon(AntDesign.form, color: Colors.purple),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // do something
                    Navigator.pushNamed(context, RouteStr.FEEDBACK);
                  },
                ),
              ),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("社群"),
                  leading: Icon(AntDesign.addusergroup, color: Colors.deepOrangeAccent),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // do something
                    Navigator.pushNamed(context, RouteStr.TXCSYS);
                  },
                ),
              ),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("分享"),
                  onTap: () => Share.share('果核', subject: 'Look what I made!'),
                  leading: Icon(AntDesign.sharealt, color: Colors.green),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              new SizedBox(height: 15),
              new Container(
                color: Colors.white,
                child: ListTile(
                    title: new Text("设置"),
                    leading: Icon(AntDesign.setting, color: Colors.blue),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => {}),
              ),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("检查更新"),
                  subtitle: Text("当前版本:" + version),
                  leading: Icon(AntDesign.info, color: Colors.blueAccent),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              new Container(
                color: Colors.white,
                child: ListTile(
                  title: new Text("切换账号"),
                  leading: Icon(AntDesign.reload1, color: Colors.black54),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => logout(),
                ),
              ),
            ],
          ),
        ));
  }

  // 首页组件
  Widget MyInfo() {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        height: 120,
        child: Stack(
          children: <Widget>[
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: new Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                // 圆角图片
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildAvatar(),
                ),
              ),
            ),
            new Align(
              alignment: FractionalOffset.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    name,
                    style: new TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("学号：" + id)
                ],
              ),
            ),
            new Align(
                alignment: FractionalOffset.centerRight,
                child: new Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(Icons.keyboard_arrow_right),
                )),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
    );
  }

  // 构造头像
  _buildAvatar() {
    if (avatar == '' || avatar == null) {
      return new Image.asset(
        StringFile.fakeAvatar,
        width: 60.0,
        fit: BoxFit.cover,
        height: 60.0,
      );
    } else {
      return new CachedNetworkImage(
          placeholder: (context, url) => new CircularProgressIndicator(),
          imageUrl: avatar,
          fit: BoxFit.cover,
          width: 60.0,
          height: 60.0);
    }
  }
}

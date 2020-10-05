import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/common/routeStr.dart';
import 'package:flutter_app/common/stringFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/updateItem.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String avatar = '';

  String name = "Unknown";
  String id = "Unknown";
  final picker = ImagePicker();

  // 登出时清空本机缓存
  Future<void> clean() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    print('cleared');
  }

  void logout() {
    clean();
    Navigator.pushReplacementNamed(context, RouteStr.LOGIN);
  }

  void getStuInfo() {
    name = SpUtil.getStringList(LocalShare.STU_INFO)[0];
    id = SpUtil.getString(LocalShare.STU_ID);
    avatar = SpUtil.getString(LocalShare.AVATAR);
  }

  // 将图片切换
  _uploadImg() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      avatar = image.path;
    });
    SpUtil.putString(LocalShare.AVATAR, avatar);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            content: Text(S.of(context).img_pick_tip),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () =>
                    Navigator.of(context).pop(), //关闭对话框
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {
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
            "",
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
                  title: new Text(S.of(context).feedback),
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
                  title: new Text(S.of(context).community),
                  leading: Icon(AntDesign.addusergroup,
                      color: Colors.deepOrangeAccent),
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
                  title: new Text(S.of(context).share),
                  onTap: () => Share.share(
                      '果核 \r' + Constant.SHARE_URL.toString()+'\r一次奇妙的尝试',),
                  leading: Icon(AntDesign.sharealt, color: Colors.green),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              new SizedBox(height: 15),
              new Container(
                color: Colors.white,
                child: ListTile(
                    title: new Text(S.of(context).setting),
                    leading: Icon(AntDesign.setting, color: Colors.blue),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, RouteStr.SETTING);
                    }),
              ),
              new Container(color: Colors.white, child: UpdateListTile()),
              new Container(
                color: Colors.white,
                child: ListTile(
                    title: new Text(S.of(context).account),
                    leading: Icon(AntDesign.reload1, color: Colors.black54),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(S.of(context).tips),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15)),
                            content: Text(S.of(context).quit_tip),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("NO"),
                                onPressed: () =>
                                    Navigator.of(context).pop(), //关闭对话框
                              ),
                              FlatButton(
                                child: Text("YES"),
                                onPressed: () => logout(),
                              ),
                            ],
                          );
                        })),
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
        height: 80,
        child: Stack(
          children: <Widget>[
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: new Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                // 圆角图片
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildAvatar(),
                  ),
                  onTap: _uploadImg,
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
        Navigator.pushNamed(context, RouteStr.PROFILE);
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
      return Image.file(File(avatar),
          fit: BoxFit.cover, width: 60.0, height: 60.0);
//      return new CachedNetworkImage(
//          placeholder: (context, url) => new CircularProgressIndicator(),
//          imageUrl: avatar,
//          fit: BoxFit.cover,
//          width: 60.0,
//          height: 60.0);
    }
  }
}

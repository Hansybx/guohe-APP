import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/common/stringFile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  String name = '';
  String avatar = '';
  String uid = '';
  String major = '';

//  var _imgPath;

  String token;
  double _process = 0.0;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  // 从缓存中获取用户信息
  Future _getUserInfo() async {
    name = SpUtil.getStringList(LocalShare.STU_INFO)[0];
    uid = SpUtil.getString(LocalShare.STU_ID);
    major = SpUtil.getString(LocalShare.STU_MAJOR);
    avatar = SpUtil.getString(LocalShare.AVATAR);
  }

  Widget _buildAvatar() {
    if (avatar == '' || avatar == null) {
      return new Image.asset(
        StringFile.fakeAvatar,
        width: 60.0,
        height: 60.0,
        fit: BoxFit.cover,
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

  // 选择图片的方式
  _chooseImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text("拍照"),
                onTap: _takePhoto,
              ),
              new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text("从相册中选择"),
                  onTap: _openGallery),
            ],
          );
        });
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _uploadImg(image);
    Navigator.pop(context);
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImg(image);
    Navigator.pop(context);
  }

  // 获取七牛云token
  Future<String> _getQiNiuToken() async {
    Response response;
    Dio dio = new Dio();
    // todo 这里先用我的七牛云，后期改掉
    // 获取七牛云token
    response = await dio.get(Constant.QNTOKEN);
    return response.data.toString();
  }

  // 将图片上传至七牛云
  _uploadImg(image) async {
    if (image == null) {
      return;
    }
    var token = await _getQiNiuToken();
    if (token != null) {
      final syStorage = new SyFlutterQiniuStorage();
      //监听上传进度
      syStorage.onChanged().listen((dynamic percent) {
        double p = percent;
        setState(() {
          _process = p;
        });
      });

      String key = DateTime.now().millisecondsSinceEpoch.toString() +
          '.' +
          image.path.split('.').last;
      //上传文件
      var result = await syStorage.upload(image.path, token, key);
      //true 上传成功，false失败
      if (result == true) {
        setState(() {
          avatar = "https://ytools.xyz/" + key;
        });
        SpUtil.putString(LocalShare.AVATAR, avatar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            elevation: 0.0,
            title: Text('个人信息',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            backgroundColor: Colors.white,
            //设置appbar背景颜色
            centerTitle: true,
            //设置标题是否局中
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, 'update');
                },
              );
            })),
        body: new Container(
          color: Colors.white,
          child: new SingleChildScrollView(
              child: new Container(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.all(10.0),
                  child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          width: double.infinity,
                          height: 100.0,
                          child: Stack(
                            children: <Widget>[
                              new Align(
                                child: new Text(
                                  "头像",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                alignment: FractionalOffset.centerLeft,
                              ),
                              new Align(
                                child: GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _buildAvatar(),
                                  ),
                                  onTap: _chooseImage,
                                ),
                                alignment: FractionalOffset.centerRight,
                              )
                            ],
                          ),
                        ),
                        new Divider(),
                        new Container(
                          width: double.infinity,
                          height: 40.0,
                          child: Stack(
                            children: <Widget>[
                              new Align(
                                child: new Text(
                                  "姓名",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                alignment: FractionalOffset.centerLeft,
                              ),
                              new Align(
                                child: Text(name),
                                alignment: FractionalOffset.centerRight,
                              )
                            ],
                          ),
                        ),
                        new Divider(),
                        new Container(
                          width: double.infinity,
                          height: 40.0,
                          child: Stack(
                            children: <Widget>[
                              new Align(
                                child: new Text(
                                  "学号",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                alignment: FractionalOffset.centerLeft,
                              ),
                              new Align(
                                child: Text(uid),
                                alignment: FractionalOffset.centerRight,
                              )
                            ],
                          ),
                        ),
                        new Divider(),
                        new Container(
                          width: double.infinity,
                          height: 40.0,
                          child: Stack(
                            children: <Widget>[
                              new Align(
                                child: new Text(
                                  "专业",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                alignment: FractionalOffset.centerLeft,
                              ),
                              new Align(
                                child: Text(major),
                                alignment: FractionalOffset.centerRight,
                              )
                            ],
                          ),
                        ),
                        new Divider(),
                        new GestureDetector(
                          child: new Container(
                            width: double.infinity,
                            height: 40.0,
                            child: Stack(
                              children: <Widget>[
                                new Align(
                                  child: new Text(
                                    "二维码名片",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                  alignment: FractionalOffset.centerLeft,
                                ),
                                new Align(
                                  child: Icon(AntDesign.qrcode),
                                  alignment: FractionalOffset.centerRight,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Toast.show("实验功能，敬请期待！", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          },
                        ),
                        new Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}

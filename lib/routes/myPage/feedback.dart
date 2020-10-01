import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/stringFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/utils/commonUtils.dart';
import 'package:flutter_app/widgets/commonWidget.dart';

class FeedBack extends StatefulWidget {
  @override
  FeedBackState createState() => new FeedBackState();
}

class FeedBackState extends State<FeedBack> {
  String token;

//  //TODO 图片上传进度条
//  double _process = 0.0;
//  var _imgPath;
//  var _imgUrl;
  var content;
  var contact;

  @override
  void initState() {
    super.initState();
  }

//  // 从缓存中获取用户信息
//  Future<String> _getUserId() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String uid = SharedPreferencesHelper.getUserId(prefs);
//    return uid;
//  }

  //反馈
  _submit() async {
//    String uid = await _getUserId();
    if (contact != null && contact != "" && content != "" && content != null) {
      try {
        Response response;
        Dio dio = new Dio();

        var feedbackData = {
          'content': content,
          'contact': contact,
          'origin': '2',
        };
//        if (_imgUrl != null && _imgUrl != "") {
//          feedbackData['pic'] = _imgUrl;
//        }
        response = await dio.post(Constant.FEEDBACK, data: feedbackData);
        Map<String, dynamic> jsonMap = json.decode(response.toString());
        if (jsonMap['code'] == 200) {
//          CommonUtils.showToast(context, "反馈成功", gravity: Toast.BOTTOM);
//          Navigator.pop(context);
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("反馈成功"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
        }
      } catch (e) {
        CommonUtils.showToast(context, "反馈异常，稍后重试");
        print(e);
      }
    } else {
      CommonUtils.showToast(context, "请将反馈内容/联系方式填写完整");
    }
  }

//  // 选择图片的方式
//  _chooseImage() {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return new Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              new ListTile(
//                leading: new Icon(Icons.camera),
//                title: new Text("拍照"),
//                onTap: _takePhoto,
//              ),
//              new ListTile(
//                  leading: new Icon(Icons.photo_library),
//                  title: new Text("从相册中选择"),
//                  onTap: _openGallery),
//            ],
//          );
//        });
//  }
//
//  /*拍照*/
//  _takePhoto() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    _uploadImg(image);
//    setState(() {
//      _imgPath = image;
//    });
//    Navigator.pop(context);
//  }
//
//  /*相册*/
//  _openGallery() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    _uploadImg(image);
//    setState(() {
//      _imgPath = image;
//    });
//    Navigator.pop(context);
//  }
//
//  // 获取七牛云token
//  Future<String> _getQiNiuToken() async {
//    Response response;
//    Dio dio = new Dio();
//    response = await dio.get(getQNToken);
//    return response.data.toString();
//  }
//
//  // 将图片上传至七牛云
//  _uploadImg(image) async {
//    if (image == null) {
//      return;
//    }
//    var token = await _getQiNiuToken();
//    if (token != null) {
//      final syStorage = new SyFlutterQiniuStorage();
//      //监听上传进度
//      syStorage.onChanged().listen((dynamic percent) {
//        double p = percent;
//        setState(() {
//          _process = p;
//        });
//        print(percent);
//      });
//
//      String key = DateTime.now().millisecondsSinceEpoch.toString() +
//          '.' +
//          image.path.split('.').last;
//      //上传文件
//      bool result = await syStorage.upload(image.path, token, key);
//      //true 上传成功，false失败
//      if (result == true) {
//        setState(() {
//          _imgUrl = "https://ytools.xyz/" + key;
//        });
//      }
//    }
//  }

//  /*图片控件*/
//  Widget _ImageView(imgPath) {
//    if (imgPath == null) {
//      return new Container(
//        decoration: new BoxDecoration(
//            border: new Border.all(width: 1.0, color: Colors.black26),
//            image: new DecorationImage(image: AssetImage(addFeedbackImg))),
//      );
//    } else {
//      return Image.file(
//        imgPath,
//      );
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(248, 248, 248, 1.0),
        appBar: Common.appBar(context,title: S.of(context).feedback),
        body: new SingleChildScrollView(
          child: new Container(
            margin: EdgeInsets.all(8.0),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Container(height: 20.0),
                  Image.asset(
                    StringFile.feedbackImg,
                    width: 60.0,
                    height: 60.0,
                  ),
                  new Container(height: 10.0),
                  Text(
                    "反馈",
                    style: TextStyle(fontSize: 18.0, color: Colors.black45),
                  ),
                  new Container(height: 10.0),
                  new Card(
                    elevation: 1.0,
                    child: new Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            '内容',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                        ),
                        new Divider(),
                        new Container(
                          height: 110.0,
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "有什么想要告诉我们的？"),
                            onChanged: (val) {
                              setState(() {
                                content = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Card(
                    elevation: 1.0,
                    child: new Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            '联系方式',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                        ),
                        new Divider(),
                        new Container(
                          height: 70.0,
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "QQ/微信，方便我们联系到你来更好的解决问题"),
                            onChanged: (val) {
                              setState(() {
                                contact = val;
                                print(contact);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
//                  new Card(
//                    elevation: 1.0,
//                    child: new Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(
//                            '选择图片（可选）',
//                            style:
//                            TextStyle(color: Colors.black45, fontSize: 16),
//                          ),
//                        ),
//                        new Divider(),
//                        new Align(
//                            alignment: Alignment.centerLeft,
//                            child: new GestureDetector(
//                              child: new Container(
//                                margin: EdgeInsets.only(
//                                    top: 15.0,
//                                    bottom: 20.0,
//                                    left: 15.0,
//                                    right: 15.0),
//                                width: 100.0,
//                                height: 100.0,
//                                child: _ImageView(_imgPath),
//                              ),
//                              onTap: _chooseImage,
//                            )),
//                      ],
//                    ),
//                  ),
                  new Container(height: 10.0),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new OutlineButton(
                          borderSide: new BorderSide(color: Colors.green),
                          child: new Container(
                            margin: EdgeInsets.all(10.0),
                            child: new Text(
                              '发射',
                              style: new TextStyle(
                                  color: Colors.green, fontSize: 20.0),
                            ),
                          ),
                          onPressed: _submit,
                        )),
                      ],
                    ),
                  ),
                  new Container(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

//class FeedBack extends StatefulWidget {
//  @override
//  _FeedBackState createState() => _FeedBackState();
//}
//
//class _FeedBackState extends State<FeedBack> {
//  var _content;
//  var _connectWay;
//
//  Future<void> _sendMsg() async {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return LoadingDialog(content: "发送中，请稍后......");
//        });
//    Response res = await Dio().post(Constant.FEEDBACK,
//        data: {'content': _content, 'contact': _connectWay, 'origin': '2'});
//    if (res.statusCode == 200) {
//      Navigator.pop(context);
//      print(res);
//      if (res.data['code'] == 200) {
//        showDialog(
//            context: context,
//            child: AlertDialog(
//              content: Text("反馈成功"),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text("确定"),
//                  onPressed: () => Navigator.of(context).pop(),
//                )
//              ],
//            ));
//      } else {
//        showDialog(
//            context: context,
//            child: AlertDialog(
//              content: Text("反馈失败"),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text("确定"),
//                  onPressed: () => Navigator.of(context).pop(),
//                )
//              ],
//            ));
//      }
//    }
//  }
//
//  void _feedback() {
//    _sendMsg();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('反馈'),
//      ),
//      body: Column(
//        children: <Widget>[
//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: TextFormField(
//              textInputAction: TextInputAction.newline,
//              initialValue: '',
//              maxLines: 6,
//              keyboardType: TextInputType.multiline,
//              decoration:
//                  new InputDecoration(labelText: '反馈内容', hintText: '内容'),
//              onChanged: (val) {
//                _content = val;
//              },
//            ),
//          ),
//          SizedBox(height: 7),
//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: TextFormField(
//              initialValue: '',
//              decoration: new InputDecoration(
//                labelText: '联系方式',
//                hintText: "请注明联系方法 QQ or 微信",
//              ),
//              onChanged: (val) {
//                _connectWay = val;
//              },
//            ),
//          ),
//          Container(
//            decoration:
//                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//            child: FlatButton(
//              onPressed: () => _feedback(),
//              child: Text('提交'),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}

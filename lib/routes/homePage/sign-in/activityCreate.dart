import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/sp_file.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:location/location.dart';

class ActivityCreate extends StatefulWidget {
  @override
  _ActivityCreateState createState() => _ActivityCreateState();
}

class _ActivityCreateState extends State<ActivityCreate> {
  String _activityName;
  String _classes;
  String _intervalTime;
  double _longitude = -1.0;
  double _latitude = -1.0;
  bool _checkboxInCreate = true;

  // get location on earth
  Future<void> realPosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      _longitude = _locationData.longitude;
      _latitude = _locationData.latitude;
    });
    print('location get');
  }

  // 活动信息提交
  void _activitySubmitted(BuildContext context) {
    if (_activityName == null || _classes == null || _intervalTime == null) {
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text("活动创建失败，表单内容不能为空"),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return LoadingDialog(content: "创建中，请稍后......");
          });
      submitParams(context, _activityName, _classes, _intervalTime);
    }
  }

  void submitParams(BuildContext context, String activityName, String classes,
      String intervalTime) {
    List classList = classes.split("@").toList();
    String semester = SpUtil.getString(LocalShare.SEMESTER);
    if (_checkboxInCreate) {
      realPosition().then((value) => submitActivity(
          context, activityName, intervalTime, semester, classList));
    } else {
      setState(() {
        _longitude = 0.0;
        _latitude = 0.0;
      });
      submitActivity(context, activityName, intervalTime, semester, classList);
    }
  }

  Future<void> submitActivity(BuildContext context, String activityName,
      String intervalTime, String semester, List classList) async {
    Map<String, dynamic> map = Map();
    map['name'] = activityName;
    map['semester'] = semester;
    map['classes'] = classList;
    map['interval'] = intervalTime;
    map['creator'] = SpUtil.getString(LocalShare.STU_ID);
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;

    Response res = await Dio().post(Constant.ACTIVITY_CREATE, data: map);
    if (res.statusCode == 200) {
      Navigator.pop(context);
//      print(res);
      if (res.data['status'] == 200) {
        showDialog(
          context: context,
          child: AlertDialog(
            content: Container(
              height: 70,
              child: Column(
                children: <Widget>[
                  Text("活动创建成功"),
                  SizedBox(
                    height: 15,
                  ),
                  Text("活动签到码为: " + res.data['data'].toString())
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            content: Text("活动创建失败"),
            actions: <Widget>[
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      }
    } else {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text("活动创建失败"),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          children: <Widget>[
            new Container(height: 20.0),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '活动名称',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _activityName = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '应签到班级',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 110.0,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      maxLines: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "应签到班级的班级号，若有多个班级用@隔开",
                      ),
                      onChanged: (val) {
                        setState(() {
                          _classes = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '签到时长',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 60.0,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Form(
                      autovalidate: true,
                      child: TextFormField(
//                              controller: _timeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "签到时长（分钟）",
                          ),
                          onChanged: (val) {
                            setState(() {
                              _intervalTime = val;
                            });
                          },
                          validator: (v) {
                            bool flag;
                            double v_num;
                            try {
                              flag = true;
                              v_num = double.parse(v);
                            } catch (e) {
                              flag = false;
                            }
                            return flag ? null : "时间必须为数字";
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "使用位置信息作为签到依据",
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                    Checkbox(
                      value: _checkboxInCreate,
                      activeColor: Colors.blue, //选中时的颜色
                      onChanged: (value) {
                        setState(() {
                          _checkboxInCreate = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            new Container(height: 10.0),
            new Padding(
              padding: new EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new OutlineButton(
                    borderSide: new BorderSide(color: Colors.blue),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Text(
                        '发射',
                        style:
                            new TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                    ),
                    onPressed: () => _activitySubmitted(context),
                  )),
                ],
              ),
            ),
            new Container(
              height: 20.0,
            )
          ],
        )),
      ),
    );
  }
}

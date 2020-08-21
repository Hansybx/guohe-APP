import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/sp_file.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:location/location.dart';

class ActivityAttend extends StatefulWidget {
  @override
  _ActivityAttendState createState() => _ActivityAttendState();
}

class _ActivityAttendState extends State<ActivityAttend> {

  String _checkCode;
  bool _checkboxInAttend = true;
  double _longitude = -1.0;
  double _latitude = -1.0;

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
    print(_locationData.longitude);
    print(_locationData.latitude);
    print('location get');
  }

  Future<void> attendCheck(BuildContext context) async {
    if (_checkboxInAttend) {
      realPosition();
    } else {
      setState(() {
        _longitude = 0.0;
        _latitude = 0.0;
      });
    }
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(content: "创建中，请稍后......");
        });

    Map<String, dynamic> signMap = Map();

    signMap['studentId'] = SpUtil.getString(LocalShare.STU_ID);
    signMap['longitude'] = _longitude;
    signMap['latitude'] = _latitude;
    signMap['signId'] = _checkCode;

    Response res =  await Dio().post(Constant.ACTIVITY_ATTEND,data: signMap);
    if (res.statusCode == 200) {
      Navigator.pop(context);
//      print(res);
      if (res.data['status'] == 200) {
        showDialog(
          context: context,
          child: AlertDialog(
            content: Text("签到成功"),
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
            content: Text("签到失败"),
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
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text("签到失败"),
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
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 5 * 4,
                child: TextFormField(
                  initialValue: '',
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelText: '签到码',
                      hintText: "请输入应出席活动签到码",
                      prefixIcon: Icon(Icons.playlist_add_check)),
                  onChanged: (val) {
                    setState(() {
                      _checkCode = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "使用位置信息作为签到依据",
                style: TextStyle(color: Colors.black45, fontSize: 16),
              ),
              Checkbox(
                value: _checkboxInAttend,
                activeColor: Colors.blue, //选中时的颜色
                onChanged: (value) {
                  setState(() {
                    _checkboxInAttend = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: FlatButton(
            child: Text("签到"),
            onPressed: () => attendCheck(context),
          ),
        ),
      ],
    );
  }
}

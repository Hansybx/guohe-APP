import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/routeStr.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeServiceMethod {
  static bool _checkboxInCreate = true;
  static String _checkCode;

  static String get checkCode => _checkCode;

  static set checkCode(String value) {
    _checkCode = value;
  }

  static double longitude = 0.0;
  static double latitude = 0.0;

  static bool get checkboxInCreate => _checkboxInCreate;

  static set checkboxInCreate(bool value) {
    _checkboxInCreate = value;
  }

  // get location on earth
//  static Future<dynamic> realPosition() async {
//    Location location = new Location();
//
//    bool _serviceEnabled;
//    PermissionStatus _permissionGranted;
//    LocationData _locationData;
//
//    _serviceEnabled = await location.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await location.requestService();
//      if (!_serviceEnabled) {
//        return;
//      }
//    }
//
//    _permissionGranted = await location.hasPermission();
//    if (_permissionGranted == PermissionStatus.denied) {
//      _permissionGranted = await location.requestPermission();
//      if (_permissionGranted != PermissionStatus.granted) {
//        return;
//      }
//    }
//    _locationData = await location.getLocation();
//      longitude = _locationData.longitude;
//      latitude = _locationData.latitude;
//    print('location get');
////    return _locationData;
//  }

  static Future<dynamic> realPosition() async {
    var status = await Permission.location.status;
    print(status);
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();

    print(statuses[Permission.location]);

    //启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest));
    //获取地理位置（直接定位）
    var result = await AMapLocationClient.getLocation(true);
    longitude = result.longitude; //经度
    latitude = result.latitude; //纬度
    print('location get');
    return result;
  }

  // sign in activity create start
  // 活动信息提交
  static void activitySubmitted(BuildContext context, String activityName,
      String classes, String intervalTime) {
    if (activityName == null || classes == null || intervalTime == null) {
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
      submitParams(context, activityName, classes, intervalTime);
    }
  }

  static void submitParams(BuildContext context, String activityName,
      String classes, String intervalTime) {
    List classList = classes.split("@").toList();

    if (_checkboxInCreate) {
      realPosition().then((value) {
        submitActivity(context, activityName, intervalTime, classList);
      });
    } else {
      submitActivity(context, activityName, intervalTime, classList);
    }
  }

//  {double longitude = 0.0, double latitude = 0.0} SpUtil.getString(LocalShare.SEMESTER);
  static Future<void> submitActivity(BuildContext context, String activityName,
      String intervalTime, List classList) async {
    Map<String, dynamic> map = Map();
    map['name'] = activityName;
    map['semester'] = SpUtil.getString(LocalShare.SEMESTER);
    map['classes'] = classList;
    map['interval'] = intervalTime;
    map['creator'] = SpUtil.getString(LocalShare.STU_ID);
    map['longitude'] = longitude.toString();
    map['latitude'] = latitude.toString();

    Dio().post(Constant.ACTIVITY_CREATE, data: map).then((res) {
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
              content: Text("活动创建失败," + res.data['message'].toString()),
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
    });
  }

  // sign in activity create end

  //sign in activity attend start
  static Future<void> attendCheck(BuildContext context) async {
    if (_checkboxInCreate) {
      realPosition().then((value) => attend(context, _checkCode));
    } else {
      attend(context, _checkCode);
    }
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(content: "发送中，请稍后......");
        });
  }

  static Future<void> attend(BuildContext context, String checkCode) async {
    Map<String, dynamic> signMap = Map();

    signMap['studentId'] = SpUtil.getString(LocalShare.STU_ID);
    signMap['longitude'] = longitude;
    signMap['latitude'] = latitude;
    signMap['signId'] = checkCode;

    await Dio().post(Constant.ACTIVITY_ATTEND, data: signMap).then((res) {
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
              content: Text("签到失败," + res.data['message']),
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
    });
  }

  //sign in activity attend end

  //sign in activity history start
  static List _activityList = [];

  static List get activityList => _activityList;

  static set activityList(List value) {
    _activityList = value;
  }

  static Future<void> activityGet() async {
    Response res = await Dio().get(Constant.ACTIVITY_HISTORY,
        queryParameters: {"id": SpUtil.getString(LocalShare.STU_ID)});
    if (res.statusCode == 200) {
//      print(res.data);
      if (res.data['status'] == 200) {
        _activityList = res.data['data'];
      }
    }
  }

  //sign in activity history end

  //sign in activity details start
  static String _snackStr = 'test';

  static String get snackStr => _snackStr;

  static set snackStr(String value) {
    _snackStr = value;
  }

  static Future<void> stuStateChange(
      BuildContext context, String stuId, String status, String signId) async {
    Map<String, dynamic> map = Map();
    map['status'] = status;
    map['signId'] = signId;
    map['stuId'] = stuId;

    Response res = await Dio().post(Constant.ACTIVITY_PERSON_STATE, data: map);
    if (res.statusCode == 200) {
//      print(res.data);
      if (res.data['status'] == 200) {
        if (status == '1') {
          _snackStr = '已添加置已签到';
        } else {
          _snackStr = '已添加置未签到';
        }
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            content: Text("签到状态更改失败"),
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
  }

//sign in activity details end

}

// 校园服务的item
List<ServiceItemViewModel> getEduServiceList(BuildContext context) {
  List<ServiceItemViewModel> eduServiceList = [
    ServiceItemViewModel(
        route: RouteStr.GPA,
        title: S.of(context).gpa,
        icon: new Image.asset("assets/imgs/core/score.png",
            width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.BUS,
        title: S.of(context).bus,
        icon:
            new Image.asset("assets/imgs/core/bus.png", width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.CLASSROOM,
        title: S.of(context).classroom,
        icon: new Image.asset("assets/imgs/core/classroom.png",
            width: 35, height: 35)),
    // 早操俱乐部暂未开启，所以canBeClick设置成false
    ServiceItemViewModel(
        route: RouteStr.PE,
        title: S.of(context).sport,
        canBeClick: false,
        icon: new Image.asset("assets/imgs/core/sport.png",
            width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.MAP,
        title: S.of(context).map,
        icon:
            new Image.asset("assets/imgs/core/map.png", width: 35, height: 35)),
//    ServiceItemViewModel(
//        route: RouteStr.SIGNINSYS,
//        title: S.of(context).sign_in_system,
//        icon: new Image.asset("assets/imgs/sign-note.png",
//            width: 35, height: 35)),
//    ServiceItemViewModel(
//        route: RouteStr.CALENDAR,
//        title: S.of(context).calendar,
//        icon:
//            new Image.asset("assets/imgs/core/kb.png", width: 35, height: 35)),
//    new ServiceItemViewModel(
//        route: "",
//        title: "二手书交易",
//        icon: new Image.asset("assets/imgs/core/xs.png", width: 35, height: 35),
//        onTap: () {
//          launchWeChatMiniProgram(username: "gh_75a1ef8c0da5");
//        })
  ];
  return eduServiceList;
}

// 校园服务的item
//List<ServiceItemViewModel> getSchoolServiceList(BuildContext context) {
//  List<ServiceItemViewModel> schoolServiceList = [
//    ServiceItemViewModel(
//        route: RouteStr.PRINT_SERVICE,
//        title: S.of(context).printService,
//        icon:
//        new Image.asset("assets/imgs/core/print_service.png", width: 35, height: 35)),
//  ];
//  return schoolServiceList;
//}

// 校园系统的item
List<ServiceItemViewModel> getSystemList(BuildContext context) {
  List<ServiceItemViewModel> eduSystemList = [
    ServiceItemViewModel(
        route: RouteStr.VPN,
        title: S.of(context).vpn,
        icon:
            new Image.asset("assets/imgs/core/vpn.png", width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.JIAOWU,
        title: S.of(context).education_system,
        icon: new Image.asset("assets/imgs/core/jiaowu.png",
            width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.INFOSYS,
        title: S.of(context).info_system,
        icon: new Image.asset("assets/imgs/core/info.png",
            width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.AOLANSYS,
        title: S.of(context).aoLan_system,
        icon: new Image.asset("assets/imgs/core/aolan.png",
            width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.PESYS,
        title: S.of(context).sports_system,
        icon:
            new Image.asset("assets/imgs/core/pe.png", width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.LABSYS,
        title: S.of(context).lab_system,
        icon:
            new Image.asset("assets/imgs/core/lab.png", width: 35, height: 35)),
    ServiceItemViewModel(
        route: RouteStr.GRADSYS,
        title: S.of(context).graduation_system,
        icon: new Image.asset("assets/imgs/core/grad.png",
            width: 35, height: 35)),
  ];
  return eduSystemList;
}

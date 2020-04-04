import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/routes/homePage/emptyClassroom.dart';
import 'package:flutter_app/routes/homePage/gpa.dart';
import 'package:flutter_app/routes/homePage/pe.dart';
import 'package:flutter_app/routes/homePage/schoolBus.dart';
import 'package:flutter_app/routes/homePage/shoolSystem.dart';
import 'package:flutter_app/routes/myPage/feedback.dart';

import 'routes/login.dart';
import 'routes/splashPage.dart';
import 'routes/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: SplashPage(),
      initialRoute: '/',
      routes: {
        RouteStr.LOGIN: (context) => Login(), //登录
        RouteStr.HOME: (context) => Tabs(), //主页面
        RouteStr.VPN: (context) => VPN(), //vpn
        RouteStr.LABSYS: (context) => ExperimentSys(), //实验系统
        RouteStr.FEEDBACK: (context) => FeedBack(), //反馈
        RouteStr.JIAOWU: (context) => JiaowuSys(), //教务系统
        RouteStr.AOLANSYS: (context) => AolanSys(), //奥兰系统
        RouteStr.PESYS: (context) => PeSys(),
        RouteStr.BUS: (context) => SchoolBus(), //校车
        RouteStr.INFOSYS: (context) => InfoSys(), //信息系统
        RouteStr.GRADSYS: (context) => GraduationProject(), //毕业设计
        RouteStr.GPA: (context) => GPA(), //gpa
        RouteStr.CLASSROOM: (context) => EmptyClassroom(),
        RouteStr.CALENDAR: (context) => CalendarSys(),
        RouteStr.PE: (context) => Pe(),
        RouteStr.TXCSYS: (context) => TXCSys(),
      },
    );
  }
}

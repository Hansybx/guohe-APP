import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/utils/AppAnalysis.dart';

import 'routes/login.dart';
import 'routes/splashPage.dart';
import 'routes/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }

//  Future<void> initPlatformState() async {
//    var result = await UmengAnalyticsPlugin.init(
//      androidKey: '5e8881fadbc2ec080a349939',
//      iosKey: '5e8886b7978eea071c37c120',
//    );
//
//    print('Umeng initialized.');
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '果核Lite',
      onGenerateRoute: Router.generateRoute,
      navigatorObservers: [AppAnalysis()],
      home: SplashPage(),
      initialRoute: '/',
//      routes: {
//        RouteStr.LOGIN: (context) => Login(), //登录
//        RouteStr.HOME: (context) => Tabs(), //主页面
//        RouteStr.VPN: (context) => VPN(), //vpn
//        RouteStr.LABSYS: (context) => ExperimentSys(), //实验系统
//        RouteStr.FEEDBACK: (context) => FeedBack(), //反馈
//        RouteStr.JIAOWU: (context) => JiaowuSys(), //教务系统
//        RouteStr.AOLANSYS: (context) => AolanSys(), //奥兰系统
//        RouteStr.PESYS: (context) => PeSys(),
//        RouteStr.BUS: (context) => SchoolBus(), //校车
//        RouteStr.INFOSYS: (context) => InfoSys(), //信息系统
//        RouteStr.GRADSYS: (context) => GraduationProject(), //毕业设计
//        RouteStr.GPA: (context) => GPA(), //gpa
//        RouteStr.CLASSROOM: (context) => EmptyClassroom(),
//        RouteStr.CALENDAR: (context) => CalendarSys(),
//        RouteStr.PE: (context) => Pe(),
//        RouteStr.TXCSYS: (context) => TXCSys(),
//      },
    );
  }
}

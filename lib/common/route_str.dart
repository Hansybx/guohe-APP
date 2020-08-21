// 存放路由字符串
import 'package:flutter/material.dart';
import 'package:flutter_app/routes/homePage/classroom.dart';
import 'package:flutter_app/routes/homePage/gpa.dart';
import 'package:flutter_app/routes/homePage/pe.dart';
import 'package:flutter_app/routes/homePage/bus.dart';
import 'package:flutter_app/routes/homePage/sign-in/activityDetail.dart';
import 'package:flutter_app/routes/homePage/sign-in/sign-in.dart';
import 'package:flutter_app/routes/homePage/system.dart';
import 'package:flutter_app/routes/login.dart';
import 'package:flutter_app/routes/myPage/about.dart';
import 'package:flutter_app/routes/myPage/feedback.dart';
import 'package:flutter_app/routes/myPage/profile.dart';
import 'package:flutter_app/routes/myPage/setting.dart';
import 'package:flutter_app/routes/tabs.dart';

class RouteStr {
  // 早操俱乐部
  static const String PE = "/pe";

  // 查成绩
  static const String GPA = "/gpa";

  // 校园公交
  static const String BUS = "/bus";

  static const String CLASSROOM = "/classroom";

  static const String FEEDBACK = "/feedback";
  static const String ABOUT = "/about";

  static const String CALENDAR = "/calendar";

  static const String VPN = "/vpn";
  static const String JIAOWU = "/jiaowu";
  static const String INFOSYS = "/infoSys";
  static const String AOLANSYS = "/aolanSys";
  static const String PESYS = "/peSys";
  static const String LABSYS = "/labSys";
  static const String GRADSYS = "/gradSys";
  static const String TXCSYS = "/TXCSys";
  static const String SIGNINSYS = "/SignInSys";
  static const String ACTIVITY_DETAIL = "/ActivityDetail";

  static const String LOGIN = "/login";
  static const String HOME = "/main";

  static const String PROFILE = "/profile";

  static const String SETTING = "/setting";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteStr.LOGIN:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.LOGIN),
          builder: (context) => Login(),
        );

      case RouteStr.HOME:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.HOME),
          builder: (context) => Tabs(),
        );

      case RouteStr.FEEDBACK:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.FEEDBACK),
          builder: (context) => FeedBack(),
        ); //反馈

      case RouteStr.ABOUT:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.ABOUT),
          builder: (context) => About(),
        );

      case RouteStr.VPN:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.VPN),
          builder: (context) => VPN(),
        ); //vpn

      case RouteStr.LABSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.LABSYS),
          builder: (context) => ExperimentSys(),
        ); //实验系统

      case RouteStr.JIAOWU:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.JIAOWU),
          builder: (context) => JiaowuSys(),
        ); //教务系统

      case RouteStr.AOLANSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.AOLANSYS),
          builder: (context) => AolanSys(),
        ); //奥兰系统

      case RouteStr.PESYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.PESYS),
          builder: (context) => PeSys(),
        );

      case RouteStr.BUS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.BUS),
          builder: (context) => SchoolBus(),
        ); //校车

      case RouteStr.INFOSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.INFOSYS),
          builder: (context) => InfoSys(),
        ); //信息系统

      case RouteStr.GRADSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.GRADSYS),
          builder: (context) => GraduationProject(),
        ); //毕业设计

      case RouteStr.GPA:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.GPA),
          builder: (context) => GPA(),
        ); //gpa

      case RouteStr.CLASSROOM:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.CLASSROOM),
          builder: (context) => EmptyClassroom(),
        );

      case RouteStr.CALENDAR:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.CALENDAR),
          builder: (context) => CalendarSys(),
        );

      case RouteStr.PE:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.PE),
          builder: (context) => Pe(),
        );

      case RouteStr.TXCSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.TXCSYS),
          builder: (context) => TXCSys(),
        );
      case RouteStr.PROFILE:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.PROFILE),
          builder: (context) => Profile(),
        );
      case RouteStr.SETTING:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.SETTING),
          builder: (context) => SettingsPage(),
        );
      case RouteStr.SIGNINSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.SIGNINSYS),
          builder: (context) => SignInSystem(),
        );
      case RouteStr.ACTIVITY_DETAIL:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.ACTIVITY_DETAIL),
          builder: (context) => ActivityDetail(),
        );
    }
  }
}

// 存放路由title
class RouteTitle {
  static const String PE = "早操俱乐部";

  static const String GPA = "成绩绩点";

  static const String BUS = "校园巴士";

  static const String CLASSROOM = "空教室";

  static const String FEEDBACK = "反馈";
  static const String ABOUT = "关于果核";

  static const String CALENDAR = "校历";

  static const String VPN = "校园VPN";
  static const String JIAOWU = "教务系统";
  static const String INFOSYS = "信息门户";
  static const String AOLANSYS = "奥兰系统";
  static const String PESYS = "体育系统";
  static const String LABSYS = "实验系统";
  static const String GRADSYS = "毕业系统";
  static const String TXCSYS = "吐个槽";

  static const String PROFILE = "个人信息";
  static const String SETTING = "设置";
}

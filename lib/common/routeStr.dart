// 存放路由字符串
import 'package:flutter/material.dart';
import 'package:flutter_app/routes/homePage/classroom.dart';
import 'package:flutter_app/routes/homePage/gpa.dart';
import 'package:flutter_app/routes/homePage/pe.dart';
import 'package:flutter_app/routes/homePage/bus.dart';
import 'package:flutter_app/routes/homePage/signIn/activityDetail.dart';
import 'package:flutter_app/routes/homePage/signIn/signIn.dart';
import 'package:flutter_app/routes/login.dart';
import 'package:flutter_app/routes/myPage/feedback.dart';
import 'package:flutter_app/routes/myPage/profile.dart';
import 'package:flutter_app/routes/myPage/setting.dart';
import 'package:flutter_app/routes/tabs.dart';
import 'package:flutter_app/widgets/browser.dart';

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

      case RouteStr.BUS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.BUS),
          builder: (context) => SchoolBus(),
        ); //校车

      case RouteStr.PE:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.PE),
          builder: (context) => Pe(),
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
      case RouteStr.VPN:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.VPN),
          builder: (context) => Browser(
            url: "https://vpn.just.edu.cn",
            title: "vpn",
          ),
        );
      case RouteStr.LABSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.LABSYS),
          builder: (context) => Browser(
            url:
                'https://vpn.just.edu.cn/sy/,DanaInfo=202.195.195.198+index.aspx',
            title: '实验系统',
          ),
        );
      case RouteStr.JIAOWU:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.JIAOWU),
          builder: (context) => Browser(
            url: 'http://jwgl.just.edu.cn:8080/',
            title: '教务系统',
          ),
        );
      case RouteStr.AOLANSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.AOLANSYS),
          builder: (context) => Browser(
            url: 'http://202.195.195.238:866/LOGIN.ASPX',
            title: '奥兰系统',
          ),
        );
      case RouteStr.INFOSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.VPN),
          builder: (context) => Browser(
            url:
                'http://ids2.just.edu.cn/cas/login?service=http%3A%2F%2Fmy.just.edu.cn%2F',
            title: '信息系统',
          ),
        );
      case RouteStr.PESYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.PESYS),
          builder: (context) => Browser(
            url: 'http://tyxy.just.edu.cn/login.asp',
            title: '体育系统',
          ),
        );
      case RouteStr.CALENDAR:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.CALENDAR),
          builder: (context) => Browser(
            url: 'http://notice.just.edu.cn/_s4/2019/1210/c132a45301/page.psp',
            title: '校历',
          ),
        );
      case RouteStr.GRADSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.GRADSYS),
          builder: (context) => Browser(
            url:
                'http://bysj.just.edu.cn/?_p=YXM9MiZ0PTImZD0xMDEmcD0xJmY9MzAmbT1OJg__&_l=&_t=',
            title: '毕业设计',
          ),
        );
      case RouteStr.TXCSYS:
        return MaterialPageRoute(
          settings: RouteSettings(name: RouteStr.TXCSYS),
          builder: (context) => Browser(
            url: 'https://support.qq.com/products/140296',
            title: '吐个槽',
          ),
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

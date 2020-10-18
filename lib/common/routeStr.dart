// 存放路由字符串
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/routerModel.dart';
import 'package:flutter_app/routes/homePage/bus.dart';
import 'package:flutter_app/routes/homePage/classroom.dart';
import 'package:flutter_app/routes/homePage/gpa.dart';
import 'package:flutter_app/routes/homePage/pe.dart';
import 'package:flutter_app/routes/homePage/schoolMap.dart';
import 'package:flutter_app/routes/homePage/signIn/signIn.dart';
import 'package:flutter_app/routes/login.dart';
import 'package:flutter_app/routes/myPage/feedback.dart';
import 'package:flutter_app/routes/myPage/profile.dart';
import 'package:flutter_app/routes/myPage/setting.dart';
import 'package:flutter_app/routes/tabs.dart';
import 'package:flutter_app/widgets/browser.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteStr {
  // 早操俱乐部
  static const String PE = "/pe";

  // 查成绩
  static const String GPA = "/gpa";

  // 校园公交
  static const String BUS = "/bus";
  static const String MAP = "/map";

  static const String CLASSROOM = "/classroom";

  static const String FEEDBACK = "/feedback";
  static const String ABOUT = "/about";

  static const String CALENDAR = "/calendar";

  static const String PRINT_SERVICE = "/printService";

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

// 存放路由title
class RouteTitle {
  static const String PE = "早操俱乐部";

  static const String GPA = "成绩绩点";

  static const String BUS = "校园巴士";

  static const String CLASSROOM = "空教室";

  static const String FEEDBACK = "反馈";
  static const String ABOUT = "关于果核";

  static const String CALENDAR = "校历";
  static const String ACTIVITY_DETAIL = "签到";

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

class RouterPath {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routeSysMap = {
      // Key:    Value
      RouteStr.VPN:
          new RouterModel("vpn", RouteStr.VPN, "https://vpn.just.edu.cn"),
      RouteStr.JIAOWU: new RouterModel(
          RouteTitle.JIAOWU, RouteStr.JIAOWU, "http://jwgl.just.edu.cn:8080/"),
      RouteStr.LABSYS: new RouterModel(RouteTitle.LABSYS, RouteStr.LABSYS,
          "https://vpn.just.edu.cn/sy/,DanaInfo=202.195.195.198+index.aspx"),
      RouteStr.AOLANSYS: new RouterModel(RouteTitle.AOLANSYS, RouteStr.AOLANSYS,
          "http://202.195.195.238:866/LOGIN.ASPX"),
      RouteStr.PESYS: new RouterModel(RouteTitle.PESYS, RouteStr.PESYS,
          "http://tyxy.just.edu.cn/login.asp"),
      RouteStr.INFOSYS: new RouterModel(RouteTitle.INFOSYS, RouteStr.INFOSYS,
          "http://ids2.just.edu.cn/cas/login?service=http%3A%2F%2Fmy.just.edu.cn%2F"),
      RouteStr.CALENDAR: new RouterModel(RouteTitle.CALENDAR, RouteStr.CALENDAR,
          "http://notice.just.edu.cn/_s4/2019/1210/c132a45301/page.psp"),
      RouteStr.GRADSYS: new RouterModel(RouteTitle.GRADSYS, RouteStr.GRADSYS,
          "http://bysj.just.edu.cn/?_p=YXM9MiZ0PTImZD0xMDEmcD0xJmY9MzAmbT1OJg__&_l=&_t="),
      RouteStr.TXCSYS: new RouterModel(RouteTitle.TXCSYS, RouteStr.TXCSYS,
          "https://support.qq.com/products/140296"),
    };

    var routePageMap = {
      RouteStr.LOGIN: Login(),
      RouteStr.HOME: Tabs(),
      RouteStr.FEEDBACK: FeedBack(),
      RouteStr.GPA: GPA(),
      RouteStr.CLASSROOM: EmptyClassroom(),
      RouteStr.BUS: SchoolBus(),
      RouteStr.MAP: SchoolMap(0),
      RouteStr.PROFILE: Profile(),
      RouteStr.PE: Pe(),
      RouteStr.SETTING: SettingsPage(),
      RouteStr.SIGNINSYS: SignInSystem(),
    };

    return MaterialPageRoute(
      builder: (context) {
        if (routePageMap.containsKey(settings.name)) {
          return routePageMap[settings.name];
        }
        if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
          return new Container(
              color: Colors.white,
              child: new AlertDialog(
                  title: new Text("提示"),
                  content: new Text("即将在浏览器中打开该页面"),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("取消"),
                    ),
                    new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        launch(routeSysMap[settings.name].path);
                      },
                      child: new Text("确定"),
                    )
                  ]));
        }
        return Browser(
          url: routeSysMap[settings.name].path,
          title: routeSysMap[settings.name].title,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/browser.dart';

//vpn
class VPN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: "https://vpn.just.edu.cn",
      title: "vpn",
    );
  }
}

// 实验系统
class ExperimentSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'https://vpn.just.edu.cn/sy/,DanaInfo=202.195.195.198+index.aspx',
      title: '实验系统',
    );
  }
}

//教务系统
class JiaowuSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://jwgl.just.edu.cn:8080/',
      title: '教务系统',
    );
  }
}

//奥兰系统
class AolanSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://202.195.195.238:866/LOGIN.ASPX',
      title: '奥兰系统',
    );
  }
}

// 信息系统
class InfoSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://ids2.just.edu.cn/cas/login?service=http%3A%2F%2Fmy.just.edu.cn%2F',
      title: '信息系统',
    );
  }
}


// 体育系统
class PeSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://tyxy.just.edu.cn/login.asp',
      title: '体育系统',
    );
  }
}

//毕业设计
class GraduationProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://bysj.just.edu.cn/?_p=YXM9MiZ0PTImZD0xMDEmcD0xJmY9MzAmbT1OJg__&_l=&_t=',
      title: '毕业设计',
    );
  }
}

//校历
class CalendarSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'http://notice.just.edu.cn/_s4/2019/1210/c132a45301/page.psp',
      title: '校历',
    );
  }
}

class TXCSys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Browser(
      url: 'https://support.qq.com/products/140296',
      title: '吐个槽',
    );
  }
}
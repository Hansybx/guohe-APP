import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/viewModel/itemVM.dart';

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
    ServiceItemViewModel(
        route: RouteStr.SIGNINSYS,
        title: S.of(context).sign_in_system,
        icon: new Image.asset("assets/imgs/sign-note.png",
            width: 35, height: 35)),
  ];
  return eduSystemList;
}

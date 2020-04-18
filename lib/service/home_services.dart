import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:fluwx/fluwx.dart';

// 校园服务的item
List<ServiceItemViewModel> eduServiceList = [
  ServiceItemViewModel(
      route: RouteStr.GPA,
      title: RouteTitle.GPA,
      icon:
          new Image.asset("assets/imgs/core/score.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.BUS,
      title: RouteTitle.BUS,
      icon: new Image.asset("assets/imgs/core/bus.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.CLASSROOM,
      title: RouteTitle.CLASSROOM,
      icon: new Image.asset("assets/imgs/core/classroom.png",
          width: 35, height: 35)),
  // 早操俱乐部暂未开启，所以canBeClick设置成false
  ServiceItemViewModel(
      route: RouteStr.PE,
      title: RouteTitle.PE,
      canBeClick: false,
      icon:
          new Image.asset("assets/imgs/core/sport.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.CALENDAR,
      title: RouteTitle.CALENDAR,
      icon: new Image.asset("assets/imgs/core/kb.png", width: 35, height: 35)),
  new ServiceItemViewModel(
      route: "",
      title: "二手书交易",
      icon: new Image.asset("assets/imgs/core/xs.png", width: 35, height: 35),
      onTap: () {
        launchWeChatMiniProgram(username: "gh_75a1ef8c0da5");
      })
];

//eduServiceList.add();

// 校园系统的item
List<ServiceItemViewModel> eduSystemList = [
  ServiceItemViewModel(
      route: RouteStr.VPN,
      title: RouteTitle.VPN,
      icon: new Image.asset("assets/imgs/core/vpn.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.JIAOWU,
      title: RouteTitle.JIAOWU,
      icon: new Image.asset("assets/imgs/core/jiaowu.png",
          width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.INFOSYS,
      title: RouteTitle.INFOSYS,
      icon:
          new Image.asset("assets/imgs/core/info.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.AOLANSYS,
      title: RouteTitle.AOLANSYS,
      icon:
          new Image.asset("assets/imgs/core/aolan.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.PESYS,
      title: RouteTitle.PESYS,
      icon: new Image.asset("assets/imgs/core/pe.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.LABSYS,
      title: RouteTitle.LABSYS,
      icon: new Image.asset("assets/imgs/core/lab.png", width: 35, height: 35)),
  ServiceItemViewModel(
      route: RouteStr.GRADSYS,
      title: RouteTitle.GRADSYS,
      icon:
          new Image.asset("assets/imgs/core/grad.png", width: 35, height: 35)),
];
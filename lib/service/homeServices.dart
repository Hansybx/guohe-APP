import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_icons/flutter_icons.dart';

// 校园服务的item
List<ServiceItemViewModel> eduServiceList = [
  ServiceItemViewModel(
      route: RouteStr.GPA,
      title: RouteTitle.GPA,
      icon: Icon(
        AntDesign.gift,
        color: Colors.purple,
      )),
  ServiceItemViewModel(
      route: RouteStr.BUS,
      title: RouteTitle.BUS,
      icon: Icon(
        Ionicons.md_bus,
        color: Colors.orangeAccent,
      )),
  ServiceItemViewModel(
      route: RouteStr.CLASSROOM,
      title: RouteTitle.CLASSROOM,
      icon: Icon(
        Feather.clipboard,
        color: Colors.blue,
      )),
  // 早操俱乐部暂未开启，所以canBeClick设置成false
  ServiceItemViewModel(
      route: RouteStr.PE,
      title: RouteTitle.PE,
      canBeClick: false,
      icon: Icon(
        Feather.star,
        color: Colors.redAccent,
      )),
  ServiceItemViewModel(
      route: RouteStr.CALENDAR,
      title: RouteTitle.CALENDAR,
      icon: Icon(
        Feather.airplay,
        color: Colors.deepOrange,
      )),
];

// 校园系统的item
List<ServiceItemViewModel> eduSystemList = [
  ServiceItemViewModel(
      route: RouteStr.VPN,
      title: RouteTitle.VPN,
      icon: Icon(
        Ionicons.md_paper_plane,
        color: Colors.lightGreen,
      )),
  ServiceItemViewModel(
      route: RouteStr.JIAOWU,
      title: RouteTitle.JIAOWU,
      icon: Icon(
        Feather.airplay,
        color: Colors.pinkAccent,
      )),
  ServiceItemViewModel(
      route: RouteStr.INFOSYS,
      title: RouteTitle.INFOSYS,
      icon: Icon(
        AntDesign.cloudo,
        color: Colors.lightBlue,
      )),
  ServiceItemViewModel(
      route: RouteStr.AOLANSYS,
      title: RouteTitle.AOLANSYS,
      icon: Icon(
        Feather.briefcase,
        color: Colors.brown,
      )),
  ServiceItemViewModel(
      route: RouteStr.PESYS,
      title: RouteTitle.PESYS,
      icon: Icon(
        Ionicons.md_american_football,
        color: Colors.pinkAccent,
      )),
  ServiceItemViewModel(
      route: RouteStr.LABSYS,
      title: RouteTitle.LABSYS,
      icon: Icon(
        AntDesign.rocket1,
        color: Colors.lightGreen,
      )),
  ServiceItemViewModel(
      route: RouteStr.GRADSYS,
      title: RouteTitle.GRADSYS,
      icon: Icon(
        AntDesign.antdesign,
        color: Colors.orange,
      )),
];

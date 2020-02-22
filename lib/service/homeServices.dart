import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_icons/flutter_icons.dart';

// 校园服务的item
const List<ServiceItemViewModel> eduServiceList = [
  ServiceItemViewModel(
      route: '/gpa',
      title: '成绩绩点',
      icon: Icon(
        AntDesign.gift,
        color: Colors.purple,
      )),
  ServiceItemViewModel(
      route: '/schoolBus',
      title: '校车',
      icon: Icon(
        Ionicons.md_bus,
        color: Colors.orangeAccent,
      )),
  ServiceItemViewModel(
      route: '/classroom',
      title: '空教室',
      icon: Icon(
        Feather.clipboard,
        color: Colors.blue,
      )),
  ServiceItemViewModel(
      route: '/schoolcalenderImg',
      title: '校历',
      icon: Icon(
        Feather.airplay,
        color: Colors.deepOrange,
      )),
];

// 校园系统的item
const List<ServiceItemViewModel> eduSystemList = [
  ServiceItemViewModel(
      route: '/vpn',
      title: '校园VPN',
      icon: Icon(
        Ionicons.md_paper_plane,
        color: Colors.lightGreen,
      )),
  ServiceItemViewModel(
      route: '/jiaowuSys',
      title: '教务系统',
      icon: Icon(
        Feather.airplay,
        color: Colors.pinkAccent,
      )),
  ServiceItemViewModel(
      route: '/infoSys',
      title: '信息门户',
      icon: Icon(
        AntDesign.cloudo,
        color: Colors.lightBlue,
      )),
  ServiceItemViewModel(
      route: '/aolanSys',
      title: '奥兰系统',
      icon: Icon(
        Feather.briefcase,
        color: Colors.brown,
      )),
  ServiceItemViewModel(
      route: '/peSys',
      title: '体育系统',
      icon: Icon(
        Ionicons.md_american_football,
        color: Colors.pinkAccent,
      )),
  ServiceItemViewModel(
      route: '/experimentSys',
      title: '实验系统',
      icon: Icon(
        AntDesign.rocket1,
        color: Colors.lightGreen,
      )),
  ServiceItemViewModel(
      route: '/graduationProject',
      title: '毕业设计',
      icon: Icon(
        AntDesign.antdesign,
        color: Colors.orange,
      )),
];

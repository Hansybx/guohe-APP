import 'package:flutter/material.dart';

import 'activityAttend.dart';
import 'activityCreate.dart';
import 'activityHistory.dart';

class SignInSystem extends StatefulWidget {
  @override
  _SignInSystemState createState() => _SignInSystemState();
}

class _SignInSystemState extends State<SignInSystem>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["响应签到", "发起签到", "发起过的签到"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("签到"),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ActivityAttend(),
          ActivityCreate(),
          ActivityHistory(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

class AppAnalysis extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {
      print("进入页面" + route.settings.name);
      UmengAnalyticsPlugin.pageStart(route.settings.name);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {
      print("退出页面" + route.settings.name);
      UmengAnalyticsPlugin.pageEnd(route.settings.name);
    }
  }
}

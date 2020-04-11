import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/utils/AppAnalysis.dart';
import 'package:fluwx/fluwx.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

import 'routes/splashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    initPlatformState();
    _initFluwx();
  }

  // 加载微信SDK
  // todo 先添加 android 端，ios端稍后做
  _initFluwx() async {
    await registerWxApi(
        appId: "wx31c614cef0a3c2b1",
        doOnAndroid: true,
        doOnIOS: false,
        universalLink: "https://your.univerallink.com/link/");
    var result = await isWeChatInstalled;
    print("WeChat SDK is installed $result");
  }

  Future<void> initPlatformState() async {
    var result = await UmengAnalyticsPlugin.init(
        androidKey: '5e8bde32167eddb52f000652',
        iosKey: '5e8b2789570df3bc8e0000a3',
        channel: "Umeng",
        logEnabled: true,
        pageCollectionMode: "MANUAL");

    print('Umeng initialized.');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '果核Lite',
      onGenerateRoute: Router.generateRoute,
      navigatorObservers: [AppAnalysis()],
      home: SplashPage(),
      initialRoute: '/',
    );
  }
}

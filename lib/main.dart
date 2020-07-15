import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/service/AppAnalysis.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:fluwx/fluwx.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

import 'routes/splash.dart';

void main() => runApp(MyApp());

ValueChanged<Locale> localeChange;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('zn', 'CN');

  @override
  void initState() {
    super.initState();

    localeChange = (locale) {
      setState(() {
        _locale = locale;
      });
    };

    _initUmeng();
    _initFluwx();
    _initUpdate();
  }

  // 加载微信SDK
  // todo 先添加 android 端，ios端稍后做
  Future<void> _initFluwx() async {
    await registerWxApi(
        appId: "wx31c614cef0a3c2b1",
        doOnAndroid: true,
        doOnIOS: false,
        universalLink: "https://your.univerallink.com/link/");
    var result = await isWeChatInstalled;
    print("WeChat SDK is installed $result");
  }

  // 初始化友盟统计
  Future<void> _initUmeng() async {
    var result = await UmengAnalyticsPlugin.init(
        androidKey: '5e8bde32167eddb52f000652',
        iosKey: '5e8b2789570df3bc8e0000a3',
        channel: "Umeng",
        logEnabled: false,
        pageCollectionMode: "MANUAL");

    print('Umeng initialized.' + result.toString());
  }

  // 初始化更新插件
  Future<void> _initUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(

              ///是否输出日志
              debug: false,

              ///是否使用post请求
              isPost: false,

              ///post请求是否是上传json
              isPostJson: false,

              ///是否开启自动模式
              isWifiOnly: false,

              ///是否开启自动模式
              isAutoMode: false,

              ///需要设置的公共参数
              supportSilentInstall: false,

              ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
              enableRetry: false)
          .then((value) {})
          .catchError((error) {
        print(error);
      });
      FlutterXUpdate.setUpdateHandler(
          onUpdateError: (Map<String, dynamic> message) async {
        print(message);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 去除右上角Debug标签
      debugShowCheckedModeBanner: false,
      // 设置语言
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      // 讲en设置为第一项,没有适配语言时,英语为首选项
      supportedLocales: S.delegate.supportedLocales,
      // 设置页面相关信息
      title: '果核Lite',
      onGenerateRoute: Router.generateRoute,
      navigatorObservers: [AppAnalysis()],
      initialRoute: '/',
      // 设置主页
      home: Builder(
        builder: (BuildContext context) {
          return Localizations.override(
            context: context,
            locale: _locale,
            child: SplashPage(),
          );
        },
      ),
    );
  }
}

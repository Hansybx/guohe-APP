import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/route_str.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '果核Lite',
      onGenerateRoute: Router.generateRoute,
      home: SplashPage(),
      initialRoute: '/',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/routes/homePage/home.dart';
import 'package:flutter_app/routes/myPage/me.dart';
import 'package:flutter_app/routes/kb.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController controller;

  var _lastPressedAt;
  int _currentIndex = 0;
  List<Widget> _pageList = [SchedulePage(), HomePage(), MyPage()];

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () async {
//        if (_lastPressedAt == null ||
//            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
//          //两次点击间隔超过1秒则重新计时
//          _lastPressedAt = DateTime.now();
//          return false;
//        }
//
//        return true;
//      },
    return new Scaffold(
      key: _scaffoldKey,
//        body: this._pageList[this._currentIndex],
      body: new TabBarView(
          controller: controller,
          children: <Widget>[new SchedulePage(), new HomePage(), new MyPage()]),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: controller,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.black26,
          tabs: <Widget>[
            new Tab(
              text: S.of(context).schedule,
              icon: new Icon(Icons.map),
            ),
            new Tab(
              text: S.of(context).discover,
              icon: new Icon(Icons.brightness_5),
            ),
            new Tab(
              text: S.of(context).me,
              icon: new Icon(Icons.directions_run),
            ),
          ],
        ),
      ),
//        bottomNavigationBar: BottomNavigationBar(
//          currentIndex: this._currentIndex,
//          onTap: (int index) {
//            setState(() {
//              this._currentIndex = index;
//            });
//          },
//          items: [
//            BottomNavigationBarItem(
//                icon: Icon(Icons.event), title: Text(S.of(context).schedule)),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.home), title: Text(S.of(context).discover)),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.person), title: Text(S.of(context).me))
//          ],
//        ),
    );
  }
}

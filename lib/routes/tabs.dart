import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/routes/homePage/home.dart';
import 'package:flutter_app/routes/kb.dart';
import 'package:flutter_app/routes/myPage/me.dart';
import 'package:flutter_app/widgets/iconFont.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController controller;

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
    return new Scaffold(
      key: _scaffoldKey,
      body: new TabBarView(controller: controller, children: _pageList),
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
              icon: new Icon(IconFont.icon_LC_icon_light_line),
            ),
            new Tab(
              text: S.of(context).me,
              icon: new Icon(Icons.directions_run),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/routes/homePage/homePage.dart';
import 'package:flutter_app/routes/myPage/myPage.dart';
import 'package:flutter_app/routes/schedulePage.dart';



class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var _lastPressedAt;
  int _currentIndex = 0;
  List _pageList = [
    SchedulePage(),
    HomePage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }

        return true;
      },
      child: Scaffold(

        body: this._pageList[this._currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
            setState(() {
              this._currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.event),
                title: Text(S.of(context).schedule)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(S.of(context).discover)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(S.of(context).me)
            )
          ],
        ),
      ),
    );
  }
}




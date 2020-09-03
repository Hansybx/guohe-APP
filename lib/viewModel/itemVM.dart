import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/commonUtils.dart';

class ServiceItem extends StatelessWidget {
  final ServiceItemViewModel widget;

  ServiceItem({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Container(
        height: 80,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: this.widget.icon,
            ),
            Expanded(
              flex: 1,
              child: Text(
                this.widget.title,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (this.widget.route == '') {
          this.widget.onTap();
        } else {
          if (this.widget.canBeClick) {
            Navigator.pushNamed(context, (this.widget.route));
          } else {
            CommonUtils.showToast(context, "当前服务暂未开启");
          }
        }
      },
    );
  }
}

class ServiceItemViewModel {
  /// 图标
  final Image icon;

  /// 标题
  final String title;

  final String route;

  bool canBeClick;

  final GestureTapCallback onTap;

  ServiceItemViewModel(
      {this.route, this.title, this.icon, this.canBeClick = true, this.onTap});
}

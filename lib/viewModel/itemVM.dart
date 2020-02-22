import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final ServiceItemViewModel widget;

  ServiceItem({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, (this.widget.route));
      },
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
    );
  }
}

class ServiceItemViewModel {
  /// 图标
  final Icon icon;

  /// 标题
  final String title;

  final String route;

  const ServiceItemViewModel({
    this.route,
    this.title,
    this.icon,
  });
}

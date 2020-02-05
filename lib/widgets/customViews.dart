
import 'package:flutter/material.dart';

//加载对话框
class LoadingDialog extends SimpleDialog {
  final String content;

  const LoadingDialog({Key key, this.content: "加载中，请稍后......"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SimpleDialog(
      children: <Widget>[
        new SizedBox(
          height: 15.0,
        ),
        new Row(
          children: <Widget>[
            new SizedBox(
              width: 20.0,
            ),
            new Expanded(
              child: new CircularProgressIndicator(),
              flex: 1,
            ),
            new SizedBox(
              width: 20.0,
            ),
            new Expanded(
              child: new Text(this.content),
              flex: 5,
            )
          ],
        ),
        new SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

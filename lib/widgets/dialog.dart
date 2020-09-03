import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/commonWidget.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog(
      {Key key,
      @required this.title,
      @required this.contentWidget,
      this.showCancel = true,
      this.showConfirm = true,
      this.actionWidgets})
      : super(key: key);

  final bool showCancel;
  final bool showConfirm;
  final String title;
  final Widget contentWidget;
  final List<Widget> actionWidgets;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Common.primaryBigTitle(content: title),
        elevation: 12.0,
        titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12),
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        actions: _buildActionWidget(context),
        content: contentWidget);
  }

  _buildActionWidget(BuildContext context) {
    List<Widget> actionWidgets = this.actionWidgets;
    if (actionWidgets == null) {
      actionWidgets = [];
      if (showCancel) {
        actionWidgets.add(FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("取消")));
      }
      if (showConfirm) {
        actionWidgets.add(FlatButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("确定")));
      }
    }
    return actionWidgets;
  }
}

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

// 选择dialog
class RadioAlertDialog extends StatelessWidget {
  RadioAlertDialog(
      {Key key,
      @required this.title,
      @required this.selectValue,
      this.showCancel = true,
      this.showConfirm = true,
      @required this.valueList})
      : super(key: key);

  final bool showCancel;
  final bool showConfirm;
  final String title;
  final String selectValue;
  final List<String> valueList;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: title,
      contentWidget: Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildRadioList(context))),
      showCancel: showCancel,
      showConfirm: showConfirm,
    );
  }

  _buildRadioList(BuildContext context) {
    List<Widget> radioList = [];
    valueList.forEach((String value) => radioList.add(RadioListTile<String>(
        value: value,
        title: Common.primaryTitle(content: value),
        activeColor: Colors.blue,
        groupValue: '$selectValue',
        onChanged: (value) {
          Navigator.of(context).pop(value);
        })));
    return radioList;
  }
}

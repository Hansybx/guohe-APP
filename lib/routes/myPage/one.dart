import 'package:flutter/material.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_app/widgets/common_widget.dart';

class One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(18.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.email,
                  color: Colors.black26,
                  size: 17.0,
                ),
                SizedBox(
                  width: 10,
                ),
                new Container(
                  child: new Text(
                    '日知录',
                    style: new TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    LocalShare.DATE,
                    textAlign: TextAlign.end,
                    style: new TextStyle(color: Color(0xFF888888)),
                  ),
                )
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          ),
          new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: NetworkImage(LocalShare.IMG_URL),
                ),
                new Margin(indent: 6.0),
                new Text(
                  LocalShare.WORD,
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          )
        ],
      ),
    );
  }
}

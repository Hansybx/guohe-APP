import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Common {
  static appBar(BuildContext context,{title: String, actions:const <Widget>[]}) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: new TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      leading: IconButton(
          icon: Icon(
            AntDesign.back,
            color: Colors.black,
          ),
          tooltip: "back",
          onPressed: () {
            Navigator.pop(context);
          }),
    );
//    return AppBar(
//      title: Text(
//        title,
//        style: TextStyle(color: Color(0xFF262d50)),
//      ),
//      actions: actions,
//      iconTheme: IconThemeData(color: Color(0xFF262d50)),
//      backgroundColor: Colors.white,
//      elevation: 0,
//    );
  }

  static iconImage({path: String, color = const Color(0xFF262d50)}) {
    return Image.asset(
      "images/$path",
      width: 24,
      height: 24,
      color: color,
    );
  }

  static circleAvatar({size = 64.0, path: String}) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: Image.asset(
        "images/$path",
        width: size,
        height: size,
      ).image,
    );
  }

  static primaryContent({content: String, color = const Color(0xFF6b7399)}) {
    return Text(
      content,
      style: TextStyle(color: color, fontSize: 16),
    );
  }

  static primarySmallTitle({content: String, color = const Color(0xFF262d50)}) {
    return Text(
      content,
      style: TextStyle(color: color, fontSize: 14),
    );
  }

  static primaryTitle({content: String, color = const Color(0xFF262d50)}) {
    return Text(
      content,
      style: TextStyle(color: color, fontSize: 16),
    );
  }

  static primaryBigTitle({content: String, color = const Color(0xFF262d50)}) {
    return Text(
      content,
      style: TextStyle(color: color, fontSize: 18),
    );
  }

  static primarySubTitle({content: String, color = const Color(0xFF8F95B3)}) {
    return Text(
      content,
      style: TextStyle(color: color, fontSize: 14),
    );
  }
}



//间隙
class Margin extends StatelessWidget {
  final double indent;

  const Margin({Key key, this.indent: 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(indent),
    );
  }
}
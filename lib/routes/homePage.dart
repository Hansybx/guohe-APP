import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homePage"),
      ),
      body: ButtonLayout(),
    );
  }
}

class ButtonLayout extends StatefulWidget {
  @override
  _ButtonLayoutState createState() => _ButtonLayoutState();
}

class _ButtonLayoutState extends State<ButtonLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Icon(Icons.school),
              ),
              Text("asdasd")

            ],
          )
        ],
      ),
    );
  }
}


//class IconContainer extends StatefulWidget {
//  var icon;
//  var func;
//
//  IconContainer(this.icon, this.func);
//
//  @override
//  _IconContainerState createState() => _IconContainerState();
//}
//
//class _IconContainerState extends State<IconContainer> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 50,
//      width: 50,
//      decoration: BoxDecoration(
//        color: Colors.blue,
//        borderRadius: BorderRadius.all(Radius.circular(10)),
//      ),
//      child: IconButton(
//          icon: Icon(this.widget.icon),
//          iconSize: 50,
//
//          alignment: Alignment.center,
//          color: Colors.white,
//          onPressed: this.widget.func),
//    );
//  }
//}

void test() {
  print("1");
}

//class IconButtonContainerLayout extends StatefulWidget {
//  @override
//  _IconButtonContainerLayoutState createState() => _IconButtonContainerLayoutState(Icons.home);
//}
//
//class _IconButtonContainerLayoutState extends State<IconButtonContainerLayout> {
////  double size = 90;
//  var icon;
//  _IconButtonContainerLayoutState(this.icon);
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 90,
//      color: Colors.green,
//      child: IconButton(
//          icon: Icon(this.icon),
//          iconSize: 90,
//          color: Colors.white,
//          onPressed: (){
//            print("1");
//          }),
//    );
//  }
//}

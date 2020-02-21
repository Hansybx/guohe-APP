import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
        body: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(
              color: Colors.white,
              height: 210,
              child: Image(image: AssetImage('assets/imgs/hw.jpg'),),
            ),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/gpa', '成绩绩点', Icon(AntDesign.carryout)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/schoolBus', '校车', Icon(Ionicons.md_bus)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/vpn', '校园VPN', Icon(Ionicons.md_paper_plane)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/peSys', '体育系统', Icon(Ionicons.md_american_football)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/experimentSys', '实验系统', Icon(AntDesign.rocket1)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/classroom', '空教室', Icon(Feather.clipboard)),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/jiaowuSys', '教务系统', Icon(Feather.airplay)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/infoSys', '信息门户', Icon(AntDesign.cloudo)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/aolanSys', '奥兰系统', Icon(Feather.briefcase)),
                ),

              ],
            ),
            Row(
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/graduationProject', '毕业设计', Icon(AntDesign.antdesign)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/schoolcalenderImg', '校历', Icon(Feather.airplay)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWellButton(
                      '/aolanSys', '奥兰系统', Icon(Feather.briefcase)),
                ),
              ],
            ),
          ],
        )
    );
  }
}

class InkWellButton extends StatefulWidget {
  String routeName;
  String funcName;
  var icon;

  InkWellButton(this.routeName, this.funcName, this.icon);

  @override
  _InkWellButtonState createState() => _InkWellButtonState();
}

class _InkWellButtonState extends State<InkWellButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, this.widget.routeName);
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
                this.widget.funcName,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//class ButtonLayout extends StatefulWidget {
//  @override
//  _ButtonLayoutState createState() => _ButtonLayoutState();
//}
//
//class _ButtonLayoutState extends State<ButtonLayout> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 100,
//      color: Colors.blue,
//      child: Stack(
//        alignment: Alignment.center,
//        fit: StackFit.loose,
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Container(
//
//                decoration: BoxDecoration(
//                  color: Colors.red,
//                  borderRadius: BorderRadius.circular(100.0),
//                ),
//                child: Icon(Icons.school),
//              ),
//              Text("asdasd")
//
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}


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

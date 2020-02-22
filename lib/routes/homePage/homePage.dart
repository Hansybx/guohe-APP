import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';
import 'package:flutter_app/viewModel/itemVM.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("果核"),
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.white,
                height: 210,
                child: Image(
                  image: AssetImage('assets/imgs/hw.jpg'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text("教务服务"),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                padding: EdgeInsets.symmetric(vertical: 0),
                children: eduServiceList
                    .map((item) => ServiceItem(widget: item))
                    .toList(),
              ),
              new Divider(),
              ListTile(
                title: Text("校园系统"),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                padding: EdgeInsets.symmetric(vertical: 0),
                children: eduSystemList
                    .map((item) => ServiceItem(widget: item))
                    .toList(),
              ),
              new Divider(),
            ],
          ),
        ));
  }
}

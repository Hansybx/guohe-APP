import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';

class ActivityCreate extends StatefulWidget {
  @override
  _ActivityCreateState createState() => _ActivityCreateState();
}

class _ActivityCreateState extends State<ActivityCreate> {
  String _activityName;
  String _classes;
  String _intervalTime;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          children: <Widget>[
            new Container(height: 20.0),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '活动名称',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _activityName = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '应签到班级',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 110.0,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      maxLines: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "应签到班级的班级号，若有多个班级用@隔开",
                      ),
                      onChanged: (val) {
                        setState(() {
                          _classes = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: new Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '签到时长',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  new Divider(),
                  new Container(
                    height: 60.0,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Form(
                      autovalidate: true,
                      child: TextFormField(
//                              controller: _timeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "签到时长（分钟）",
                          ),
                          onChanged: (val) {
                            setState(() {
                              _intervalTime = val;
                            });
                          },
                          validator: (v) {
                            bool flag;
                            try {
                              flag = true;
                              double v_num = double.parse(v);
                            } catch (e) {
                              flag = false;
                            }
                            return flag ? null : "时间必须为数字";
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              child: Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "使用位置信息作为签到依据",
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                    Checkbox(
                      value: HomeServiceMethod.checkboxInCreate,
                      activeColor: Colors.blue, //选中时的颜色
                      onChanged: (value) {
                        setState(() {
//                          _checkboxInCreate = value;
                          HomeServiceMethod.checkboxInCreate=value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            new Container(height: 10.0),
            new Padding(
              padding: new EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new OutlineButton(
                    borderSide: new BorderSide(color: Colors.blue),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Text(
                        '发射',
                        style:
                            new TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                    ),
                    onPressed: () => HomeServiceMethod.activitySubmitted(context,_activityName, _classes, _intervalTime),
                  )),
                ],
              ),
            ),
            new Container(
              height: 20.0,
            )
          ],
        )),
      ),
    );
  }
}

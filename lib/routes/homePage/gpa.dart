import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GPA extends StatefulWidget {
  @override
  _GPAState createState() => _GPAState();
}

class _GPAState extends State<GPA> {
  var _passwd, _uid;
  List GPA_res = [];
  List ScoreRes = [];

  @override
  void initState() {
    super.initState();
    futureReady(context);
  }

//  获取学号密码
  void futureReady(BuildContext context) {
    _uid = SpUtil.getString(LocalShare.STU_ID);
    _passwd = SpUtil.getString(LocalShare.STU_PASSWD);
    print(_uid);
    print('c');
  }

//  获取绩点
  Future<void> getGPA(BuildContext context, String uid, String passwd) async {
    print('a');

    FormData formData = FormData.fromMap({"username": uid, "password": passwd});
    Response response = await Dio().post(Constant.GPA, data: formData);

    print('b');
    if (response.statusCode == 200) {
//      response.data['code'] = 402;
      if (response.data['code'] == 200) {
        GPA_res.addAll(response.data['info']);
      } else if (response.data['code'] == 402) {
        print('pingjiao');
      }
      print(GPA_res);
    } else {
      print(GPA_res);
    }
  }

//绩点组件渲染
  Widget GPABuild() {
    List<Widget> info = [];
    Widget content;
//    int x = -1;
    for (var item in GPA_res) {
//      x++;
      info.add(Container(
//        color: x % 2 == 1 ? Colors.blue : Colors.lightBlueAccent,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Divider(height: 1.0,indent: 6.0,color: Colors.black),
            SizedBox(height: 3,),
            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  item['year'],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(item['point'].toString()),
              )
            ]),
          ],
        ),
      ));
    }
    content = Column(
      children: info,
    );

    return content;
  }

//  获取成绩信息
  Future<void> getScore(BuildContext context, String uid, String passwd) async {
    FormData formData = FormData.fromMap({"username": uid, "password": passwd});
    Response response = await Dio().post(Constant.SCORE, data: formData);

    if (response.statusCode == 200) {
      if (response.data['code'] == 200) {
        ScoreRes.addAll(response.data['info']);
      } else if (response.data['code'] == 402) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('强智系统未评教请在强智教务评教后在查询'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            });
      }
      print(ScoreRes);
    } else {
      print(ScoreRes);
    }
  }

  Widget ScoreBuild() {
    List<Widget> info = [];
    Widget content;
    int x = -1;
    for (var item in ScoreRes) {
      x++;
      info.add(Container(
        color: x % 2 == 1 ? Color(int.parse("0xffe6f3f9")): Colors.white70,
//        color: x % 2 == 1 ? Colors.blueAccent.withOpacity(0.8) : Colors.lightBlueAccent,
        child: Column(
          children: <Widget>[
            Divider(height: 1.0,indent: 6.0,color: Colors.black),
            SizedBox(height: 3,),
            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  item['courseName'],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(item['credit'].toString()),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  item['score'],
                ),
              ),
            ]),
          ],
        ),
      ));
    }
    content = Column(
      children: info,
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '成绩绩点',
          textAlign: TextAlign.center,
        ),
      ),
      body: DefaultTextStyle(
        //字体style默认继承设置
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            FutureBuilder(
              //异步等待组件
              future: getGPA(context, _uid, _passwd),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 等待
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()));
                }
                // 异步结束
                else if (snapshot.connectionState == ConnectionState.done) {
                  print('d');
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Container(
                      color: Colors.white,
                      child: Text("Error:查询失败"),
                    );
                  } else {
                    // 请求成功，显示数据
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xffe6f3f9")),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text('学期'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('绩点'),
                              ),
                            ],
                          ),
                          GPABuild(),
                        ],
                      ),
                    );
                  }
                } else {
                  // 加载动画
                  return Container(
                      color: Colors.white, child: CircularProgressIndicator());
                }
              },
            ),
            Divider(height: 15,indent: 10,endIndent: 10,thickness: 10.0,color: Colors.black,),
//            SizedBox(
//              height: 15,
//            ),
            FutureBuilder(
              future: getScore(context, _uid, _passwd),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Container(
                      color: Colors.white,
                      child: Text("Error:查询失败"),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Container(
                          color: Color(int.parse("0xffe6f3f9")),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text('科目'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('学分'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('分数'),
                              ),
                            ],
                          ),
                        ),
                        ScoreBuild(),
                      ],
                    );
                  }
                } else {
                  return Container();
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

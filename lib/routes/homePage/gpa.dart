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
      GPA_res.addAll(response.data['info']);
      print(GPA_res);
    } else {
      print(GPA_res);
    }
  }


//绩点组件渲染
  Widget GPABuild() {
    List<Widget> info = [];
    Widget content;
    int x = -1;
    for (var item in GPA_res) {
      x++;
      info.add(Container(
        color: x % 2 == 1 ? Colors.white : Colors.greenAccent,
        child: Row(children: <Widget>[
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
      ScoreRes.addAll(response.data['info']);
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
        color: x % 2 == 1 ? Colors.white : Colors.greenAccent,
        child: Row(children: <Widget>[
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
      body: DefaultTextStyle(   //字体style默认继承设置
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            FutureBuilder(    //异步等待组件
              future: getGPA(context, _uid, _passwd),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 等待
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 7,
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(Feather.loader),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              '查询中,请稍后.......',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none),
                            ),
                          )
                        ],
                      ));
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
                      color: Colors.white,
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
                  return Container(
                      color: Colors.white, child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
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
                          color: Colors.green,
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

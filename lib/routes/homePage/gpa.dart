import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/commonWidget.dart';
import 'package:flutter_app/widgets/gpaLinear.dart';

class GPA extends StatefulWidget {
  @override
  _GPAState createState() => _GPAState();
}

class _GPAState extends State<GPA> {
  String _passwd, _uid;
  List GPA_res = [];
  List ScoreRes = [];
  Future<void> _getScore;
  Future<void> _getGPA;

  String semester = "全部学期";

  @override
  void initState() {
    super.initState();
    futureReady(context);
    // 防止futureBuilder重绘
    _getGPA = getGPA(context, _uid, _passwd);
    _getScore = getScore(context, _uid, _passwd);
  }

//  获取学号密码
  void futureReady(BuildContext context) {
    _uid = SpUtil.getString(LocalShare.STU_ID);
    _passwd = SpUtil.getString(LocalShare.STU_PASSWD);
  }

//  获取绩点
  Future<void> getGPA(BuildContext context, String uid, String passwd) async {
    FormData formData = FormData.fromMap({"username": uid, "password": passwd});
    Response response = await Dio().post(Constant.GPA, data: formData);

    if (response.statusCode == 200) {
//      response.data['code'] = 402;
      if (response.data['code'] == 200) {
        GPA_res.clear();
        GPA_res.addAll(response.data['info']);
      } else if (response.data['code'] == 402) {
        GPA_res.addAll(response.data['info']);
        print('pingjiao');
      }
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
            Divider(height: 1.0, indent: 6.0, color: Colors.black),
            SizedBox(
              height: 3,
            ),
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
        ScoreRes.clear();
        ScoreRes.addAll(response.data['info']);
      } else if (response.data['code'] == 402) {
        ScoreRes.addAll(response.data['info']);
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
    } else {
      print(ScoreRes);
    }
  }

  Widget ScoreBuild() {
    List<Widget> info = [];
    Widget content;
    int x = -1;
    for (var item in ScoreRes) {
      if (this.semester == item['startSemester'] ||
          this.semester == "all" ||
          this.semester == "全部学期") {
        x++;
        info.add(Container(
          color: x % 2 == 1 ? Color(int.parse("0xffe6f3f9")) : Colors.white70,
//        color: x % 2 == 1 ? Colors.blueAccent.withOpacity(0.8) : Colors.lightBlueAccent,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 3,
              ),
              Row(children: <Widget>[
                Expanded(
                    flex: 4,
                    child: new Container(
                      margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              item['courseName'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: new TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            "学分: " + item['credit'].toString() + "分",
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                color: Colors.black54, fontSize: 16),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        width: 40,
                        height: 40,
                        color: isFailedExam(item['score'])
                            ? Colors.blue
                            : Colors.red,
                        child: Center(
                          child: Text(
                            item['score'],
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ));
      } else {
        continue;
      }
    }
    content = Column(
      children: info,
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(context,title: S.of(context).gpa),
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
              future: _getGPA,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 等待
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()));
                }
                // 异步结束
                else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Container(
                      color: Colors.white,
                      child: Text("Error:查询失败"),
                    );
                  } else {
                    // 请求成功，显示数据
                    return Container(
                        width: double.infinity,
                        height: 250,
                        child: GPALinear(
                          data: GPA_res,
                        ));
                  }
                } else {
                  // 加载动画
                  return Container(
                      color: Colors.white, child: CircularProgressIndicator());
                }
              },
            ),
            FutureBuilder(
//              future: getScore(context, _uid, _passwd),
              future: _getScore,
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
                        ListTile(
                          title: Text('学期'),
                          subtitle: Text(semester),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: changeSemester,
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

  // 更改学期触发的事件
  void changeSemester() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
            content: new Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 60.0 * GPA_res.length,
          child: Column(
            children: <Widget>[
              ListTile(title: Text(S.of(context).semester)),
              Expanded(
                  child: ListView.builder(
                itemCount: GPA_res.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(GPA_res[index]['year'].toString()),
                      onTap: () {
                        Navigator.of(context).pop(index);
                        if (index != null) {
                          print("点击了：$index");
                        }
//                        this.semester = GPA_res[index]['year'];
                        setState(() {
                          this.semester = GPA_res[index]['year'];
                        });
                      });
                },
              )),
            ],
          ),
        ));
      },
    );
  }

  // 判断是否挂科
  bool isFailedExam(var item) {
    //todo 完善挂科的逻辑判断
    String str = item.toString();
    if (str == '未通过') return false;
    try {
      if (int.parse(str) < 60) return false;
    } on Exception {}
    return true;
  }
}

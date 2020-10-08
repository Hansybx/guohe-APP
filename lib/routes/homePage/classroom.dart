import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/commonWidget.dart';
import 'package:flutter_app/widgets/dialog.dart';

class EmptyClassroom extends StatefulWidget {
  @override
  _EmptyClassroomState createState() => _EmptyClassroomState();
}

class _EmptyClassroomState extends State<EmptyClassroom> {
  var _passwd, _uid;
  List ClsEmptyRes = [];
  String areaValue = '梦溪校区(东校区)', zcValue = '第1周', weekValue = "周一";
  var buildValue = "综合楼C";
  var _semester = "2020-2021-1";

  Map areaParaList = {
    "梦溪校区(东校区)": '01',
    "南校区": '02',
    "西校区": '03',
    "张家港": '04',
    "苏州理工": '05',
    "长山校区": 'd5'
  };

  var eastBuildingArray = ["综合楼B", "综合楼C", "综合楼D", "教三", "教四", "实验楼11", "计算中心"];
  var southBuildingArray = ["一综", "二综", "A楼", "实验楼"];
  var westBuildingArray = ["西综", "图书馆"];
  var zhangBuildingArray = ["教学楼E", "教学楼F"];
  var suBuildingArray = ["教学楼A", "教学楼B", "教学楼C", "教学楼D", "外语楼", "经管数理", "船海土木"];
  var changshangBuildingArray = [
    "12号楼-文理大楼",
    "13号楼-教学楼B1",
    "14号楼-教学楼B2",
    "16号楼-教学楼C"
  ];
  var orderArray = ['第一大节', '第二大节', '第三大节', '第四大节', '第五大节'];
  var zcArray = [
    '第1周',
    '第2周',
    '第3周',
    '第4周',
    '第5周',
    '第6周',
    '第7周',
    '第8周',
    '第9周',
    '第10周',
    '第11周',
    '第12周',
    '第13周',
    '第14周',
    '第15周',
    '第16周',
    '第17周',
    '第18周',
    '第19周',
    '第20周'
  ];
  var weekArray = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  var buildingParaList = {
    "综合楼B": 2,
    "综合楼C": 3,
    "综合楼D": 4,
    "教三": 5,
    "教四": 6,
    "实验楼11": 7,
    "计算中心": 15,
    "一综": 12,
    "二综": 23,
    "A楼": 13,
    "实验楼": 16,
    "西综": 10,
    "图书馆": 11,
    "教学楼E": 26,
    "教学楼F": 27,
    "教学楼A": 18,
    "教学楼B": 19,
    "教学楼C": 20,
    "教学楼D": 21,
    "外语楼": 22,
    "经管数理": 24,
    "船海土木": 25,
    '12号楼-文理大楼': 'D125477CBD644218826C99653EA4B96C',
    '13号楼-教学楼B1': "31D5B6B2A5664092A19527E80194D896",
    '14号楼-教学楼B2': "0B58165E4E5B4E6E9FDD26F78CCA1231",
    '16号楼-教学楼C': "57F3153B05B641EBA83F586E3CFC9B33"
  };

  var chooseBuildingArray = Map();

  void chooseBuildingArrayInit() {
    chooseBuildingArray['梦溪校区(东校区)'] = eastBuildingArray;
//    chooseBuildingArray['南校区'] = southBuildingArray;
//    chooseBuildingArray['西校区'] = westBuildingArray;
    chooseBuildingArray['张家港'] = zhangBuildingArray;
    chooseBuildingArray['苏州理工'] = suBuildingArray;
    chooseBuildingArray['长山校区'] = changshangBuildingArray;
  }

  //  获取学号密码
  void futureReady() {
    _uid = SpUtil.getString(LocalShare.STU_ID);
    _passwd = SpUtil.getString(LocalShare.STU_PASSWD);
    _semester = SpUtil.getStringList(LocalShare.ALL_YEAR)[0];
  }

  //空教室获取
  Future<void> getClassroom(BuildContext context, String uid, String passwd,
      String semester, String areaId, String buildingId, int week) async {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(content: S.of(context).loading);
        });
    FormData formData = FormData.fromMap({
      "username": uid,
      "password": passwd,
      "semester": semester,
      "area_id": areaId,
      "building_id": buildingId,
      "week": week.toString(),
    });

    Response response =
        await Dio().post(Constant.CLASSROOM_EMPTY, data: formData);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      if (response.data['code'] == 200) {
        ClsEmptyRes = response.data['info'];
        // 成功获取信息后更新
        setState(() {
          ClassRoomBuild();
        });
      }
    }
  }

  Widget ClassRoomBuild() {
    List<Widget> info = [];
    Widget content;
//    int x = -1;
    for (var item in ClsEmptyRes) {
      if (weekArray.indexOf(weekValue) + 1 == item['weekday']) {
//        x++;
        info.add(Container(
//          color: x % 2 == 1 ? Colors.white : Colors.blueGrey,
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
                    item['place'],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(orderArray[item['time'] - 1]),
                ),
              ]),
            ],
          ),
        ));
      }
    }
    content = Column(
      children: info,
    );

    return content;
  }

  @override
  void initState() {
    super.initState();
    futureReady();
    chooseBuildingArrayInit();
    buildValue = chooseBuildingArray[areaValue][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(context, title: S.of(context).classroom),
      body: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('校区:'),
                      SizedBox(
                        width: 15,
                      ),
                      //校区
                      Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          value: areaValue,
                          hint: Text(
                            '请选择校区',
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              areaValue = newValue;
                              buildValue = chooseBuildingArray[areaValue][0];
                            });
                          },
                          items: <String>['梦溪校区(东校区)', '张家港', '苏州理工', '长山校区']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('教学楼:'),
                      SizedBox(
                        width: 15,
                      ),
                      // 教学楼
                      Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          value: buildValue,
                          hint: Text('请选择教学楼'),
                          onChanged: (String newValue) {
                            setState(() {
                              buildValue = newValue;
                            });
                          },
                          items: chooseBuildingArray[areaValue]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('周次:'),
                      SizedBox(
                        width: 15,
                      ),
                      // 周次
                      Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          value: zcValue,
                          hint: Text('周次'),
                          onChanged: (String newValue) {
                            setState(() {
                              zcValue = newValue;
                            });
                          },
                          items: zcArray
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('星期:'),
                      SizedBox(
                        width: 15,
                      ),
                      //星期几
                      Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          value: weekValue,
                          hint: Text('星期'),
                          onChanged: (String newValue) {
                            setState(() {
                              weekValue = newValue;
                            });
                          },
                          items: weekArray
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () => getClassroom(
                        context,
                        _uid,
                        _passwd,
                        _semester,
                        areaParaList[areaValue],
                        buildingParaList[buildValue].toString(),
                        zcArray.indexOf(zcValue) + 1),
                    child: Text('搜索'),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('教室'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('课时'),
                      )
                    ],
                  ),
                  ClassRoomBuild(),
                ],
              )),
        ),
      ),
    );
  }
}

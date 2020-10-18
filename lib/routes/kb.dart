import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var semesterValue, semesters, weekValue, weekNum, _uid, _passwd;

//  List schoolArea = ["梦溪", "长山"];
  String schoolAreaValue = "长山";
  String imgBackground = "";

  Map _modifyCardValue = {};

  var today = DateTime.now();
  var now = DateTime.now();
  var mondayInWeek, monthInWeek, gapWeek;
  var month = [
    '一月',
    '二月',
    '三月',
    '四月',
    '五月',
    '六月',
    '七月',
    '八月',
    '九月',
    '十月',
    '十一月',
    '十二月',
  ];
  Map dayOfWeek = {};
  List day7 = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  List colorArrays = [
    "0xffccabd8",
    "0xff86e3ce",
    "0xff97d1c0",
    "0xffd76350",
    "0xff7fdb93",
    "0xff92b6c7",
    "0xffeee8aa",
//    "0xffb46a7f"
//    "0xff33CC33", // 绿
//    "0xff3399ff", // 蓝
//    "0xffff6666", // 红-粉
//    "0xffCC9933", // 褐
//    "0xff99CCFF", // 青
  ];

  var monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  List wlist = []; //要显示的课程的list
  List kb = []; //所有课表的list
  bool kbHas;
  bool otherWeekVisible = true;
  var classMore;
  List handledClassInfo = [];
  Map jieciArea;
  List jieciArrayMengXi = [
    '''第一大节 8:00 
     9:40''',
    '''第二大节10:00
    11:40''',
    '''第三大节14:00
    15:40''',
    '''第四大节15:50
    17:30''',
    '''第五大节19:00
    20:40''',
  ];
  List jieciArrayChangShan = [
    '''第一大节 8:30 
     10:05''',
    '''第二大节10:25
    12:00''',
    '''第三大节13:30
    15:05''',
    '''第四大节15:25
    17:00''',
    '''第五大节18:30
    20:05''',
  ];
  List jieciArray = [
    '''第一大节 8:30 
     10:05''',
    '''第二大节10:25
    12:00''',
    '''第三大节13:30
    15:05''',
    '''第四大节15:25
    17:00''',
    '''第五大节18:30
    20:05''',
  ];

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

  Map otherWeekColor = {'true': Color(0xffd3d3d3), 'false': Colors.transparent};

  void initValue() {
    semesters = SpUtil.getStringList(LocalShare.ALL_YEAR);
    semesterValue = semesters[0] ??
        (today.year - 1).toString() + '-' + (today.year).toString() + '-2';
    weekNum = SpUtil.getInt(LocalShare.SERVER_WEEK)+SpUtil.getInt(LocalShare.WEEK_ADVANCE,defValue: 0);
    if (weekNum > 20 || weekNum <= 0 || weekNum == null) {
      weekNum = 1;
    }
    weekValue = zcArray[weekNum - 1];
    otherWeekVisible = SpUtil.getBool(LocalShare.CLASS_VISIBLE, defValue: true);
    schoolAreaValue = SpUtil.getString(LocalShare.SCHOOLAREA, defValue: "长山");
    imgBackground = SpUtil.getString(LocalShare.BACKGROUND);
    jieciArea = {"梦溪": jieciArrayMengXi, "长山": jieciArrayChangShan};
  }

  void localGet() {
    classMore = SpUtil.getString(LocalShare.CLASS_MORE);
    var temp = SpUtil.getObjectList(LocalShare.HANDLED_KB);
    kbHas = SpUtil.getBool(LocalShare.IS_OPEN_KB);
    if (temp != null) {
      handledClassInfo = temp;
    }
  }

  //  获取学号密码
  void futureReady() {
    _uid = SpUtil.getString(LocalShare.STU_ID);
    _passwd = SpUtil.getString(LocalShare.STU_PASSWD);
  }

  // 课表数据获取
  Future<void> getSchedule() async {
    futureReady();
    if (kbHas != null && kbHas == true) {
      handledClassInfo = [];
      kb = [];
      wlist = [];
    }

    FormData formData = FormData.fromMap({
      "username": _uid,
      "password": _passwd,
      "semester": semesterValue,
    });
    await Dio().post(Constant.KB, data: formData).then((res) {
      if (res.statusCode == 200) {
//        Navigator.of(context).pop();
        if (res.data['code'] == 200) {
          int x = 0;
          kb.addAll(res.data['info']);
          classMore = kb[kb.length - 1]['more'];
          SpUtil.putString(LocalShare.CLASS_MORE, classMore);
          for (var item in kb) {
            x++;
            for (var i = 0; i < day7.length; i++) {
              if (item[day7[i]] != null) {
//                item['jieci'] = x;
                handleClassFirst(item[day7[i]], day7[i], x);
              } else {
                var temp = {
                  'weekday': day7[i],
                  'jieci': x,
                  'courseName':'',
                  'classroom':'',
                  'courseNum': '',
                  'classWeek': '0-20(周)',
                  'des': 'null'
                }; // 当前课节没有课
                handledClassInfo.add(temp);
              }
            }
          }
          var temp = handledClassInfo;
          SpUtil.putBool(LocalShare.IS_OPEN_KB, true);
          kbHas = true;
          SpUtil.putObjectList(LocalShare.HANDLED_KB, temp);
//          SpUtil.putObjectList(LocalShare.HANDLED_KB, handledClassInfo);
          classInWeek(handledClassInfo);
        }
      }
    });
  }

  // res信息初整理
  void handleClassFirst(classInfo, weekday, jieci) {
    var items = classInfo.toString().split('---------------------');
    List tempList = [];
    for (var i = 0; i < items.length; i++) {
      var temp = items[i].toString().split('@');
      if (temp.length < 5) {
        temp.add(' ');
      }
      var day = {
        'weekday': weekday,
        'courseNum': temp[0],
        'courseName': temp[1],
        'des': temp[1] + '@' + temp[4],
        'teacher': temp[2],
        'classWeek': temp[3],
        'classroom': temp[4],
        'jieci': jieci
      };
      if (i >= 1) {
        tempList.add(day);
        handledClassInfo[handledClassInfo.length - 1]['otherClasses'] =
            tempList;
        continue;
      }
      handledClassInfo.add(day);
    }
//    classInWeek(handledClassInfo);
  }

  // 筛选当前周次上的课有哪些
  void classInWeek(handledClasses, {bool other = false}) {
    for (var item in handledClasses) {
      var weekArray = item['classWeek']
          .toString()
          .substring(0, item['classWeek'].toString().length - 3)
          .split(',');
      var x = 0;
      bool added = false;
      for (var wItem in weekArray) {
        try {
          x++;
          var ss = wItem.split('-');
          var begin = int.parse(ss[0]);
//        var temp =ss
          var end = int.parse(ss[ss.length - 1]);
          if (weekNum >= begin && weekNum <= end ||
              weekNum == begin ||
              weekNum == end) {
            if (other) {
              wlist[wlist.length - 1] = item;
              return null;
            } else {
              wlist.add(item);
            }
//          wlist.add(item);
            added = true;
          } else if (x == weekArray.length) {
            if (added) {
              break;
            }
            // 当前位置有课但是本周不上
            Map temp = Map.from(item);
            temp['otherWeek'] = true;
            if (other) {
              wlist[wlist.length - 1] = temp;
            } else {
              wlist.add(temp);
            }
          }
        } catch (e) {
          continue;
        }
      }
      // 同一位置有多个课程
      if (item.containsKey('otherClass-es') && added == false) {
        classInWeek(item['otherClasses'], other: true);
      }
    }
    if (other == false) {
      // 第一周课程信息渲染
      setState(() {
        kbBuild(1);
        kbBuild(2);
        kbBuild(3);
        kbBuild(4);
        kbBuild(5);
      });
    }
  }

  Widget courseCard(var cardWidth, var cardHeight, List courseList, int index) {
    return Card(
      margin: EdgeInsets.fromLTRB(cardWidth, cardHeight, cardWidth, cardHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/imgs/plane.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 200.0,
            child: DefaultTextStyle(
//                                  softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    '课程详情',
                    style: TextStyle(
                      color: Colors.blue.withOpacity(0.85),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '课程名:' + courseList[index]['courseName'].toString() ??
                              " ",
                        ),
                        Text('课程号:' +
                                courseList[index]['courseNum'].toString() ??
                            " "),
                        Text(
                            '教室:' + courseList[index]['classroom'].toString() ??
                                " "),
                        Text(
                            '周数:' + courseList[index]['classWeek'].toString() ??
                                " "),
                        Text(
                            '任课教师:' + courseList[index]['teacher'].toString() ??
                                " "),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: SizedBox(
              width: 260,
              child: RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('关闭'),
                color: Colors.blue.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget modifyCardTextField(String labelText, String changeValueKey,
      {String initValue, String hintText}) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.text,
      initialValue: initValue,
      decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hintText ?? "",
          labelText: labelText,
          prefixIcon: Icon(
            Icons.fiber_new,
          )),
      onChanged: (val) {
        setState(() {
          _modifyCardValue[changeValueKey] = val;
        });
        print(val);
      },
    );
  }

  void modifyCourse(BuildContext context, int index) {
    String des = "";
    des += _modifyCardValue['courseName'].toString().length > 0
        ? _modifyCardValue['courseName'].toString()
        : "";
    des += _modifyCardValue['classroom'].toString().length > 0
        ? "@" + _modifyCardValue['classroom'].toString()
        : "";
    _modifyCardValue['des'] = des.length > 0 ? des : "null";
    if (_modifyCardValue['classWeek'].toString().indexOf('周') == -1) {
      _modifyCardValue['classWeek'] += "(周)";
    }
    setState(() {
      wlist[index] = _modifyCardValue;
      SpUtil.putObjectList(LocalShare.HANDLED_KB, wlist);
    });
    Navigator.pop(context);
  }

  Widget modifyCard({List course, int index}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image(
                    width: 250,
                    height: 191,
                    image: AssetImage('assets/imgs/modify_card.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: modifyCardTextField('课程名', 'courseName',
                            initValue: course == null
                                ? ''
                                : course[index]['courseName']),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: modifyCardTextField('教室位置', 'classroom',
                            initValue: course == null
                                ? ''
                                : course[index]['classroom']),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: modifyCardTextField('上课周次', 'classWeek',
                            initValue: course == null
                                ? ''
                                : course[index]['classWeek']
                                    .toString()
                                    .substring(0,
                                        course[index]['classWeek'].length - 3),
                            hintText: "连续周次使用-连接，隔开的周次使用,分隔"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: modifyCardTextField('老师', 'teacher',
                            initValue:
                                course == null ? '' : course[index]['teacher']),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 13,
                ),
                SizedBox(
                  width: 260,
                  child: RaisedButton(
                    onPressed: () => modifyCourse(context, index),
                    child: Text('关闭'),
                    color: Colors.blue.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kbBuild(int jieci) {
    List<Widget> info = [];
    Widget content;
//    int x = -1;
    // 节次信息 第几大节
    info.add(Container(
      height: 120,
      width: 40,
      color: Colors.white,
      child: Text(
        jieciArea[schoolAreaValue][jieci - 1],
        textAlign: TextAlign.center,
      ),
    ));
    for (var i = 0; i < wlist.length; i++) {
      // 当前课节是否有课程
      if (wlist[i]['des'] == 'null' && wlist[i]['jieci'] == jieci) {
        info.add(
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 0, 1, 1),
              child: InkWell(
                onTap: () => print(1),
                onLongPress: () => showDialog(
                    context: context,
                    builder: (context) {
                      _modifyCardValue = wlist[i];
                      return modifyCard(index: i);
                    }),
                child: Container(
                  color: Colors.transparent,
                  height: 120,
//                   child: Text('test'),
                ),
              ),
            ),
          ),
        );
      } else if (wlist[i]['jieci'] == jieci) {
        info.add(Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(1, 0, 1, 1),
            child: InkWell(
              // 未点击显示
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: wlist[i]['otherWeek'] != null
                      ? otherWeekVisible == false
                          ? Colors.transparent
                          : Colors.white
                      : Colors.white,
                  decoration: TextDecoration.none,
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: wlist[i]['otherWeek'] != null
                        ? otherWeekColor[otherWeekVisible.toString()]
                        : Color(int.parse(colorArrays[int.parse(
                            Random().nextInt(colorArrays.length).toString())])),
                  ),
//                  width: MediaQuery.of(context).size.width / 8,
                  height: 117,
                  child: Text(
                    wlist[i]['des'],
                  ),
                ),
              ),
              onTap: () {
                // 只有一节课
                if (wlist[i]['otherClasses'] == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return courseCard(
                            MediaQuery.of(context).size.width / 11,
                            MediaQuery.of(context).size.height / 7,
                            wlist,
                            i);
                      });
                } else {
                  // 多节课同一位置
                  List temp = [];
                  temp.add(wlist[i]);
                  for (var item in wlist[i]['otherClasses']) {
                    temp.add(item);
                  }
                  showDialog(
                    context: context,
                    child: Swiper(
                      index: 0,
                      itemCount: temp.length,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height,
                      layout: SwiperLayout.STACK,
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return courseCard(
                            MediaQuery.of(context).size.width / 11,
                            MediaQuery.of(context).size.height / 7,
                            temp,
                            index);
                      },
                    ),
                  );
                }
              },
              onLongPress: () => showDialog(
                  context: context,
                  builder: (context) {
                    _modifyCardValue = wlist[i];
                    return modifyCard(course: wlist, index: i);
                  }),
            ),
          ),
        ));
      }
    }

    content = Row(
      children: info,
    );

    return content;
  }

  void initTime() {
    var temp = today;
    mondayJudge(temp);
    dateHandle(mondayInWeek, temp);
  }

  //周一判断
  void mondayJudge(today2Handle) {
    if (today2Handle.weekday == 1) {
      mondayInWeek = today2Handle;
    } else {
//      mondayInWeek = today2Handle.day - today2Handle.weekday + 1;
      mondayInWeek = today2Handle.add(Duration(days: 1 - today2Handle.weekday));
    }
  }

  // 当前周对应日期
  void dateHandle(monday2Handle, today2Handle) {
    for (var i = 0; i < day7.length; i++) {
      dayOfWeek[day7[i]] = monday2Handle.add(Duration(days: i)).day;
    }
    monthInWeek = today2Handle.month;
  }

  Widget timeRow() {
    List weekdayList = [
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wen,
      S.of(context).thus,
      S.of(context).fri,
      S.of(context).sat,
      S.of(context).sun
    ];
    List<Widget> weekList = [];
    Widget content;
    weekList.add(Container(
      width: 40,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text(monthInWeek.toString()),
          Text('月'),
        ],
      ),
    ));

    for (int i = 0; i < weekdayList.length; i++) {
      weekList.add(Expanded(
        flex: 1,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Text(weekdayList[i]),
              Text(dayOfWeek[day7[i]].toString()),
            ],
          ),
        ),
      ));
    }

    content = Row(
      children: weekList,
    );

    return content;
  }

  @override
  void initState() {
    super.initState();

    initValue();
    initTime();
    localGet();
    if (kbHas != null && kbHas == true) {
      classInWeek(handledClassInfo);
    } else {
      getSchedule();
    }

    bool flag = SpUtil.getBool(LocalShare.AUTO_UPDATE, defValue: true);
    if (flag) {
      if (Platform.isAndroid) FlutterXUpdate.checkUpdate(url: Constant.UPDATE);
    }
  }

  _buildBackground() {
    if (imgBackground == '' || imgBackground == null) {
      return BoxDecoration(color: Colors.white);
    } else {
      return BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(imgBackground)),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 下拉筛选框
            DropdownButton(
              value: semesterValue,
              onChanged: (val) {
                setState(() {
                  semesterValue = val;
                });
                getSchedule();
              },
              items: semesters.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              width: 10,
            ),
            Text('|'),
            SizedBox(
              width: 20,
            ),
            //周次
            DropdownButton(
              isDense: true,
              value: weekValue,
              onChanged: (newValue) {
                setState(() {
                  gapWeek =
                      zcArray.indexOf(newValue) - zcArray.indexOf(weekValue);
                  weekValue = newValue;
                  weekNum = zcArray.indexOf(weekValue) + 1;
                  wlist.clear();
                  classInWeek(handledClassInfo);

                  now = now.add(Duration(days: gapWeek * 7));
                  mondayJudge(now);
                  dateHandle(mondayInWeek, now);
                });
              },
              items: zcArray.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getSchedule,
        child: Container(
          decoration: _buildBackground(),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                new Container(
                  height: 10,
                  color: Colors.white,
                ),

                // 月份 日期
                DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    decoration: TextDecoration.none,
                  ),
                  child: timeRow(),
                ),
                new Container(
                  height: 2,
                ),
                // 当前节次对应课程
                kbBuild(1),
                kbBuild(2),
                kbBuild(3),
                kbBuild(4),
                kbBuild(5),
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      width: 30,
                      child: Text(S.of(context).classMore),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.white, child: Text(classMore ?? '无')),
                    )
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}

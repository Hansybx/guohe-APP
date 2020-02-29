import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:flutter_app/widgets/customViews.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var semesterValue, semesters, weekValue, weekNum, _uid, _passwd;

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
    "0xfff56a79",
    "0xff86e3ce",
    "0xffccabd8",
    "0xff00af54",
    "0xffa7c957",
//    "0xff33CC33", // 绿
//    "0xff3399ff", // 蓝
//    "0xffff6666", // 红-粉
//    "0xffCC9933", // 褐
//    "0xff99CCFF", // 青
  ];

  var monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  var wlist = []; //要显示的课程的list
  var kb = []; //所有课表的list
  bool kbHas;
  var classMore;
  var handledClassInfo = [];
  var jieciArray = [
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

  void initValue() {
    semesters = SpUtil.getStringList(LocalShare.ALL_YEAR);
    print(semesters);
    semesterValue = semesters[0] ??
        (today.year - 1).toString() + '-' + (today.year).toString() + '-2';
    weekNum = SpUtil.getInt(LocalShare.SERVER_WEEK);
    if (weekNum > 20 || weekNum == null) {
      weekNum = 1;
    }
    weekValue = zcArray[weekNum - 1];
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
//      SpUtil.putObjectList(LocalShare.HANDLED_KB,[]);
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
      print('Dio');

//      showDialog(
//          context: context,
//          builder: (context) {
//            return LoadingDialog(content: "查询中，请稍后......");
//          });
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
        temp.add('null');
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
        print('a');
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
          var temp = {
            'weekday': item['weekday'],
            'jieci': item['jieci'],
            'des': 'null'
          };
          if (other) {
            wlist[wlist.length - 1] = temp;
          } else {
            wlist.add(temp);
          }
        }
      }
      // 同一位置有多个课程
      if (item.length > 8 && added == false) {
        classInWeek(item['otherClasses'], other: true);
      }
    }
    if (other == false) {
      print('a');
      // 第一周课程信息渲染
//      if (weekNum == 1) {
      setState(() {
        kbBuild(1);
        kbBuild(2);
        kbBuild(3);
        kbBuild(4);
        kbBuild(5);
      });
//      }
    }
  }

  Widget kbBuild(int jieci) {
    List<Widget> info = [];
    Widget content;
//    int x = -1;
    // 节次信息 第几大节
    info.add(Container(
      height: 120,
      width: 40,
      child: Text(
        jieciArray[jieci - 1],
        textAlign: TextAlign.center,
      ),
    ));
//    for (var item in wlist) {
    for (var i = 0; i < wlist.length; i++) {
      // 当前课节是否有课程
      if (wlist[i]['des'] == 'null' && wlist[i]['jieci'] == jieci) {
        info.add(
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 0, 1, 1),
              child: Container(
                color: Colors.white70,
                height: 120,
//              child: Text('test'),
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
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(int.parse(colorArrays[int.parse(
                        Random().nextInt(colorArrays.length).toString())])),
                  ),
//                  width: MediaQuery.of(context).size.width / 8,
                  height: 120,

                  child: Text(
                    wlist[i]['des'],
                  ),
                ),
              ),
              onTap: () {
                final popup = BeautifulPopup(
                  context: context,
                  template: TemplateSuccess,
                );
                // 只有一节课
                if (wlist[i]['otherClasses'] == null) {
                  popup.show(
                    title: '课程详情',
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text('课程名:' + wlist[i]['courseName']),
                          Text('课程号:' + wlist[i]['courseNum']),
                          Text('教室:' + wlist[i]['classroom']),
                          Text('周数:' + wlist[i]['classWeek']),
                          Text('任课教师:' + wlist[i]['teacher']),
                        ],
                      ),
                    ),
                    actions: [
                      popup.button(
                        label: 'Close',
                        onPressed: Navigator.of(context).pop,
                      ),
                    ],
                  );
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
                      itemWidth: 300.0,
                      itemHeight: 500.0,
                      layout: SwiperLayout.STACK,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0)),
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
                                              '课程名:' + temp[index]['courseName'].toString().length.toString(),
                                            ),
                                            Text('课程号:' + temp[index]['courseNum']),
                                            Text('教室:' + temp[index]['classroom']),
                                            Text('周数:' + temp[index]['classWeek']),
                                            Text('任课教师:' + temp[index]['teacher']),
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
                                    child: Text('close'),
                                    color: Colors.blue.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                print('1');
              },
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
    print('b');
    var temp = today;
    mondayJudge(temp);
    dateHandle(mondayInWeek, temp);
    print(dayOfWeek);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Text('课表')),
            Expanded(
                flex: 1,
                child: Text(
                  today.month.toString() + '月' + today.day.toString() + '日',
                  textAlign: TextAlign.end,
                )),
//            Expanded(flex: 1,child: Text(today.year.toString()+'年',textAlign: TextAlign.end,),)
            Text(
              today.year.toString() + '年',
              textAlign: TextAlign.end,
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getSchedule,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 下拉筛选框
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //学期
                  DropdownButton(
                    value: semesterValue,
                    onChanged: (val) {
                      setState(() {
                        semesterValue = val;
                        print(semesterValue);
                      });
                      getSchedule();
                    },
                    items:
                        semesters.map<DropdownMenuItem<String>>((String value) {
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
                    value: weekValue,
                    onChanged: (newValue) {
                      setState(() {
                        gapWeek = zcArray.indexOf(newValue) -
                            zcArray.indexOf(weekValue);
                        weekValue = newValue;
                        weekNum = zcArray.indexOf(weekValue) + 1;
                        wlist.clear();
                        classInWeek(handledClassInfo);

//                      var temp = today;
                        now = now.add(Duration(days: gapWeek * 7));
                        mondayJudge(now);
                        dateHandle(mondayInWeek, now);
                      });
                    },
                    items:
                        zcArray.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // 月份 日期
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      child: Column(
                        children: <Widget>[
                          Text(monthInWeek.toString()),
                          Text('月'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周一'),
                          Text(dayOfWeek[day7[0]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周二'),
                          Text(dayOfWeek[day7[1]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周三'),
                          Text(dayOfWeek[day7[2]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周四'),
                          Text(dayOfWeek[day7[3]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周五'),
                          Text(dayOfWeek[day7[4]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周六'),
                          Text(dayOfWeek[day7[5]].toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text('周日'),
                          Text(dayOfWeek[day7[6]].toString()),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    width: 30,
                    child: Text('备注'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(classMore ?? '无'),
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

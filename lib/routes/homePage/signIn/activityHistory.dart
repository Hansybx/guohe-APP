import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';

import 'activityDetail.dart';

class ActivityHistory extends StatefulWidget {
  @override
  _ActivityHistoryState createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {

  var _statusMap = {'1': "已结束", '0': "进行中"};
  var _colorsMap = {'1': Colors.red, '0': Colors.green};

//  Future<void> activityGet() async {
//    Response res = await Dio().get(Constant.ACTIVITY_HISTORY,
//        queryParameters: {"id": SpUtil.getString(LocalShare.STU_ID)});
//    if (res.statusCode == 200) {
////      print(res.data);
//      if (res.data['status'] == 200) {
//        setState(() {
//          _activityList = res.data['data'];
//        });
//      }
//    }
//  }

  void actDetail(String signId) {
    print('signId:' + signId);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ActivityDetail(
        signId: signId,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    HomeServiceMethod.activityGet();
  }

  Widget activityListWidget() {
    List<Widget> actInfoList = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    if (HomeServiceMethod.activityList.isNotEmpty) {
      for (var item in HomeServiceMethod.activityList) {
        actInfoList.add(Card(
          elevation: 2.0,
          margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 10.0),
          child: InkWell(
            onTap: () => actDetail(item['signInId'].toString()),
            child: Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.black, fontSize: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications_active,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              item['name'],
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "状态:" + _statusMap[item['isOverTime'].toString()],
                          style: TextStyle(
                            color: _colorsMap[item['isOverTime'].toString()],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timelapse,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("创建时间" + item['createTime'].toString()),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("学期" + item['year']),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.rate_review,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("签到码：" + item['signInId'].toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      content = new ListView(children: actInfoList);
    } else {
      content = Center(
        child: Container(
          child: Text(
            "你还没有发起过签到",
            style: TextStyle(color: Colors.black45, fontSize: 16),
          ),
        ),
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: HomeServiceMethod.activityGet, child: Container(child: activityListWidget()));
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/service/homeServices.dart';

class ActivityDetail extends StatefulWidget {
  ActivityDetail({this.signId});

  final String signId;

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabControllerInDetail;
  List tabs = [
    "已签到",
    "未签到",
  ];

  var _statusTips = {
    '0': "迟到",
    '1': '已签到',
    '2': '未签到',
  };

  List _successPersons = [];
  List _failPersons = [];

  @override
  void initState() {
    super.initState();
    _tabControllerInDetail = TabController(length: tabs.length, vsync: this);
    detailsGet();
    print(this.widget.signId);
  }

//  Future<void> stuStateChange(
//      String stuId, String status, String signId) async {
//    Map<String, dynamic> map = Map();
//    map['status'] = status;
//    map['signId'] = signId;
//    map['stuId'] = stuId;
//
//    Response res = await Dio().post(Constant.ACTIVITY_PERSON_STATE, data: map);
//    if (res.statusCode == 200) {
////      print(res.data);
//      if (res.data['status'] == 200) {
//        if (status == '1') {
//          setState(() {
//            _snackStr = '已添加置已签到';
//          });
//        } else {
//          setState(() {
//            _snackStr = '已添加置未签到';
//          });
//        }
//      }else{
//        showDialog(
//          context: context,
//          child: AlertDialog(
//            content: Text("签到状态更改失败"),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("确定"),
//                onPressed: () => Navigator.of(context).pop(),
//              )
//            ],
//          ),
//        );
//      }
//    }
//  }
//
  Future<void> detailsGet() async {
    Response res = await Dio().get(Constant.ACTIVITY_DETAIL,
        queryParameters: {"id": this.widget.signId});
    if (res.statusCode == 200) {
//      print(res.data);
      if (res.data['status'] == 200) {
        setState(() {
          _successPersons = res.data['data']['successList'];
          _failPersons = res.data['data']['failList'];
        });
      }else{
        showDialog(
          context: context,
          child: AlertDialog(
            content: Text("信息获取失败"),
            actions: <Widget>[
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      }
    }
  }

  Widget _detailListView(List personList, String signId, bool direct) {
    print(personList);
    // direct: left false right true
    if(personList.length>0){
      return ListView.builder(
        itemCount: personList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            // Key
            key: Key('key${personList[index]}'),
            // Child
            child: Card(
              elevation: 2.0,
              margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 10.0),
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
                            Icons.person,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                personList[index]['name'],
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.bookmark,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("学号：" + personList[index]['uid'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.not_listed_location,
                            color: personList[index]['status'] == '1'
                                ? Colors.blue
                                : Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "状态：" + _statusTips[personList[index]['status']],
                            style: TextStyle(
                                color: personList[index]['status'] == '1'
                                    ? Colors.black
                                    : Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                HomeServiceMethod.stuStateChange(context,personList[index]['uid'], '1', signId)
                    .then((value) => Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(HomeServiceMethod.snackStr),
                )));
                // 从右向左  也就是add
              } else if (direction == DismissDirection.startToEnd) {
                HomeServiceMethod.stuStateChange(context,personList[index]['uid'], '2', signId)
                    .then((value) => Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(HomeServiceMethod.snackStr),
                )));
              }
              // 删除后刷新列表，以达到真正的删除

              setState(() {
                direct
                    ? _failPersons[index]['status'] = '1'
                    : _successPersons[index]['status'] = '2';
                direct
                    ? _successPersons.add(_failPersons.elementAt(index))
                    : _failPersons.add(_successPersons.elementAt(index));
                direct
                    ? _failPersons.removeAt(index)
                    : _successPersons.removeAt(index);
              });
            },
            background: Container(
              color: Colors.green,
              // 这里使用 ListTile 因为可以快速设置左右两端的Icon
              child: ListTile(
                leading: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: direct ? Colors.green : Colors.white,
                    ),
                    Text(
                      "本条记录设为未签到",
                      style:
                      TextStyle(color: direct ? Colors.green : Colors.white),
                    )
                  ],
                ),
                trailing: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.arrow_back,
                      color: direct ? Colors.white : Colors.green,
                    ),
                    Text(
                      "本条记录设为已签到",
                      style:
                      TextStyle(color: direct ? Colors.white : Colors.green),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }else{
      return Center(
        child: Container(
          child: Text(
            direct ? "所有人都已经签到完了":"尚未有人签到",
            style: TextStyle(color: Colors.black45, fontSize: 16),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我发起的签到"),
        bottom: TabBar(
            controller: _tabControllerInDetail,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabControllerInDetail,
        children: <Widget>[
          RefreshIndicator(
              onRefresh: detailsGet,
              child:
                  _detailListView(_successPersons, this.widget.signId, false)),
          RefreshIndicator(
              onRefresh: detailsGet,
              child: _detailListView(_failPersons, this.widget.signId, true))
        ],
      ),
    );
  }
}

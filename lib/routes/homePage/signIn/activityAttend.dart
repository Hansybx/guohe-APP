import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';

class ActivityAttend extends StatefulWidget {
  @override
  _ActivityAttendState createState() => _ActivityAttendState();
}

class _ActivityAttendState extends State<ActivityAttend> {


//  Future<void> attendCheck(BuildContext context) async {
//    if (_checkboxInAttend) {
//      realPosition().then((value) => attend(context));
//    } else {
//      setState(() {
//        _longitude = 0.0;
//        _latitude = 0.0;
//      });
//      attend(context);
//    }
//    showDialog(
//        context: context,
//        builder: (context) {
//          return LoadingDialog(content: "发送中，请稍后......");
//        });
//  }
//
//  Future<void> attend(BuildContext context) async {
//    Map<String, dynamic> signMap = Map();
//
//    signMap['studentId'] = SpUtil.getString(LocalShare.STU_ID);
//    signMap['longitude'] = _longitude;
//    signMap['latitude'] = _latitude;
//    signMap['signId'] = _checkCode;
//
//    Response res =  await Dio().post(Constant.ACTIVITY_ATTEND,data: signMap);
//    if (res.statusCode == 200) {
//      Navigator.pop(context);
////      print(res);
//      if (res.data['status'] == 200) {
//        showDialog(
//          context: context,
//          child: AlertDialog(
//            content: Text("签到成功"),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("确定"),
//                onPressed: () => Navigator.of(context).pop(),
//              )
//            ],
//          ),
//        );
//      } else {
//        showDialog(
//          context: context,
//          child: AlertDialog(
//            content: Text("签到失败,"+res.data['message']),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("确定"),
//                onPressed: () => Navigator.of(context).pop(),
//              )
//            ],
//          ),
//        );
//      }
//    } else {
//      Navigator.of(context).pop();
//      showDialog(
//        context: context,
//        child: AlertDialog(
//          content: Text("签到失败"),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("确定"),
//              onPressed: () => Navigator.of(context).pop(),
//            )
//          ],
//        ),
//      );
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 5 * 4,
                  child: TextFormField(
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: '签到码',
                        hintText: "请输入应出席活动签到码",
                        prefixIcon: Icon(Icons.playlist_add_check)),
                    onChanged: (val) {
                      setState(() {
                        HomeServiceMethod.checkCode = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "使用位置信息作为签到依据",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
                Checkbox(
                  value: HomeServiceMethod.checkboxInCreate,
                  activeColor: Colors.blue, //选中时的颜色
                  onChanged: (value) {
                    setState(() {
                      HomeServiceMethod.checkboxInCreate = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.blue),
              child: Text("签到",style: TextStyle(color: Colors.blue),),
              onPressed: () => HomeServiceMethod.attendCheck(context),
            ),
          ),
        ],
      ),
    );
  }
}

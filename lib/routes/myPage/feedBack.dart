import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_app/widgets/customViews.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  var _content;
  var _connectWay;

  Future<void> _sendMsg() async {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(content: "发送中，请稍后......");
        });
    Response res = await Dio().post(Constant.FEEDBACK,
        data: {'content': _content, 'contact': _connectWay,'origin': '2'});
    if (res.statusCode == 200) {
      Navigator.pop(context);
      print(res);
      if(res.data['code'] == 200){
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text("反馈成功"),
              actions: <Widget>[
                FlatButton(
                  child: Text("确定"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
      }else{
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text("反馈失败"),
              actions: <Widget>[
                FlatButton(
                  child: Text("确定"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
      }
    }
  }

  void _feedback(){
    _sendMsg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width ,

            child: TextFormField(
              textInputAction: TextInputAction.newline,
              initialValue: '',
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              decoration: new InputDecoration(
                  labelText: '反馈内容',
                  hintText: '内容'),
              onChanged: (val) {
                _content = val;
              },
            ),
          ),
          SizedBox(height: 7),
          Container(
            width: MediaQuery.of(context).size.width ,
            child: TextFormField(
              initialValue: '',
              decoration: new InputDecoration(
                  labelText: '联系方式',
                  hintText: "请注明联系方法 QQ or 微信",
                  ),
              onChanged: (val) {
                _connectWay = val;
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: FlatButton(
              onPressed: () => _feedback(),
              child: Text('提交'),
            ),
          )
        ],
      ),
    );
  }
}



import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';

import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _account;
  String _password;
  bool pwdShow = false;

  //表单验证方法
  void _forSubmitted(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(content: "登录中，请稍后......");
        });
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();

      getCalendarInLogin(_account.trim(), _password.trim()).then((val) {
        login(context, _account.trim(), _password.trim());
      });
    } else {
      AlertDialog(
        content: Text("账号密码错误"),
        actions: <Widget>[
          FlatButton(
            child: Text("确定"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  }

  //校历
  Future<void> getCalendarInLogin(uid, passwd) async {
    if (uid != null) {
      FormData formData = FormData.fromMap({
        "username": uid,
        "password": passwd,
      });
      await Dio().post(Constant.CALENDAR, data: formData).then((res) {
        print(res);
        if(res.data["code"] == 200){
          print('calendar');
          List<String> temp = List<String>.from(res.data['info']['allYear']);
          SpUtil.putStringList(LocalShare.ALL_YEAR, temp);
          SpUtil.putInt(LocalShare.SERVER_WEEK, res.data['info']['weekNum']);
        }else{
          Navigator.of(context).pop();
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("账号密码错误"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
        }
      });
    }
  }

  //登录
  void login(BuildContext context, String account, String password) async {

    FormData formData =
        FormData.fromMap({"username": account, "password": password});
    Response res = await Dio().post(Constant.LOGIN, data: formData);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      print(res);
      // 数据缓存
      if (res.data['code'] == 200) {
        String name = res.data['info'][0]['name'];
        String academy = res.data['info'][0]['academy'];
        String major = res.data['info'][0]['major'];

        List<String> list = new List();
        list.add(name);
        list.add(academy);
        list.add(major);
        store(list,major);
        print('loginflag');
        print(LocalShare.loginFlag);
        Navigator.pushReplacementNamed(context, '/main');
        print('login end');
      } else {
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text("账号密码错误"),
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

  // 本地存储
  void store(List<String> list,String major) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(LocalShare.IS_LOGIN, true);
    sharedPreferences.setStringList(LocalShare.STU_INFO, list);
    sharedPreferences.setString(LocalShare.STU_MAJOR,major);
    sharedPreferences.setString(LocalShare.STU_ID, _account.trim());
    sharedPreferences.setString(LocalShare.STU_PASSWD, _password.trim());
    print('in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(int.parse("0xff65dbff")),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 55),
              Image(
                width: 250,
                height: 191,
                image: AssetImage('assets/imgs/login_background.png'),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Theme(
                  data: ThemeData(primaryColor: Colors.black,),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 5 * 4,
                          child: TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            initialValue: '',

                            decoration: new InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelText: '学号',
                                prefixIcon: Icon(
                                  Icons.person,
                                )),
                            onChanged: (val) {
                              _account = val;
                            },
                          ),
                        ),
                        SizedBox(height: 7),
                        Container(
                          width: MediaQuery.of(context).size.width / 5 * 4,
                          child: TextFormField(
                            initialValue: '',
                            obscureText: !pwdShow,
                            decoration: new InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                labelText: '密码',
                                hintText: "强智教务系统密码",
                                suffixIcon: IconButton(
                                    icon: Icon(pwdShow
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        pwdShow = !pwdShow;
                                      });
                                    }),
                                prefixIcon: Icon(Icons.lock_outline)),
                            onChanged: (val) {
                              _password = val;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: FlatButton(
                  child: Text("登录"),
                  onPressed: () => _forSubmitted(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

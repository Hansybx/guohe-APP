import 'package:flutter/material.dart';
import 'package:flutter_app/routes/homePage/emptyClassroom.dart';
import 'package:flutter_app/routes/homePage/gpa.dart';
import 'package:flutter_app/routes/homePage/schoolBus.dart';
import 'package:flutter_app/routes/homePage/shoolSystem.dart';
import 'package:flutter_app/routes/myPage/feedback.dart';

import 'routes/login.dart';
import 'routes/splashPage.dart';
import 'routes/tabs.dart';

//void main() => runApp(new MyApp());

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: SplashPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => Login(), //登录
        '/main': (context) => Tabs(), //主页面
        '/vpn': (context) => VPN(), //vpn
        '/experimentSys': (context) => ExperimentSys(), //实验系统
        '/feedback': (context) => FeedBack(), //反馈
        '/jiaowuSys': (context) => JiaowuSys(), //教务系统
        '/aolanSys': (context) => AolanSys(), //奥兰系统
        '/peSys': (context) => PeSys(),
        '/schoolBus': (context) => SchoolBus(), //校车
        '/infoSys': (context) => InfoSys(), //信息系统
        '/graduationProject': (context) => GraduationProject(), //毕业设计
        '/gpa': (context) => GPA(), //gpa
        '/classroom': (context) => EmptyClassroom(),
        '/schoolcalenderImg': (context) => CalendarSys(),
      },
    );
  }
}

//SharedPreferences sp = await SharedPreferences.getInstance();
//sp.clear();

//class Test extends StatefulWidget {
//  @override
//  _TestState createState() => _TestState();
//}
//
//class _TestState extends State<Test> {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope();
//  }
//}

//get(BuildContext context) async {
//  var flag;
//  SharedPreferences sp = await SharedPreferences.getInstance();
//  flag = sp.getBool(LocalShare.IS_LOGIN);
//  if (flag) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));
//  }
//}

//class LoginJudge extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    if(LocalShare.loginFlag){
//      Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));
//    }
//    return Login();
//  }
//}

// *******************************

//class Login extends StatefulWidget {
//
//  @override
//  _LoginState createState() => _LoginState();
//}
//
//class _LoginState extends State<Login> {
//  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//
//  String _account;
//  String _password;
//  bool pwdShow = false;
//
//  // 本地存储
//  void store(List<String> list) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.setBool(LocalShare.IS_LOGIN, true);
//    sharedPreferences.setStringList(LocalShare.STU_INFO, list);
//    LocalShare.loginFlag = sharedPreferences.getBool(LocalShare.IS_LOGIN);
//  }
//
//  //表单验证方法
//  void _forSubmitted(BuildContext context) {
//    var _form = _formKey.currentState;
//    if (_form.validate()) {
////      _form.save();
//      login(context, _account.trim(), _password.trim());
//    }
//    else {
//      AlertDialog(
//        content: Text("账号密码错误"),
//        actions: <Widget>[
//          FlatButton(
//            child: Text("确定"),
//            onPressed: () => Navigator.of(context).pop(),
//          )
//        ],
//      );
//    }
//  }
//
//  //登录
//  Future<void> login(
//      BuildContext context, String account, String password) async {
//    Dio dio = new Dio();
//    showDialog(
//        context: context,
//        builder: (context) {
//          return LoadingDialog(content: "登录中，请稍后......");
//        });
//    FormData formData =
//        FormData.fromMap({"username": account, "password": password});
//    Response res = await dio.post(Constant.LOGIN, data: formData);
//    if (res.statusCode == 200) {
//      Navigator.pop(context);
//      print(res);
//      if (res.data['code'] == 200) {
//        String name = res.data['info'][0]['name'];
//        String academy = res.data['info'][0]['academy'];
//        String major = res.data['info'][0]['major'];
//        String stuId = account;
//        String stuPasswd = password;
//        List<String> list = new List();
//        list.add(name);
//        list.add(academy);
//        list.add(major);
//        list.add(stuId);
//        list.add(stuPasswd);
//        store(list);
//        Navigator.push(
//          context,
//          new MaterialPageRoute(builder: (context) => Tabs()),
//        );
//      } else {
//        showDialog(
//            context: context,
//            child: AlertDialog(
//              content: Text("账号密码错误"),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text("确定"),
//                  onPressed: () => Navigator.of(context).pop(),
//                )
//              ],
//            ));
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          decoration: new BoxDecoration(
//            gradient: LinearGradient(
//                begin: Alignment.bottomCenter,
//                colors: [Colors.redAccent, Colors.orange]),
//          ),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              SizedBox(height: 55),
//              Image(
//                width: 250,
//                height: 191,
//                image: AssetImage('assets/imgs/login_background.png'),
//              ),
//              Form(
//                key: _formKey,
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      width: MediaQuery.of(context).size.width / 5 * 4,
//                      child: TextFormField(
//                        autofocus: true,
//                        keyboardType: TextInputType.number,
//                        initialValue: '',
//                        decoration: new InputDecoration(
//                            labelText: '学号', prefixIcon: Icon(Icons.person)),
//                        onChanged: (val) {
//                          _account = val;
//                        },
//                      ),
//                    ),
//                    SizedBox(height: 7),
//                    Container(
//                      width: MediaQuery.of(context).size.width / 5 * 4,
//                      child: TextFormField(
//                        initialValue: '',
//                        obscureText: !pwdShow,
//                        decoration: new InputDecoration(
//                            labelText: '密码',
//                            hintText: "强智教务系统密码",
//                            suffixIcon: IconButton(
//                                icon: Icon(pwdShow
//                                    ? Icons.visibility_off
//                                    : Icons.visibility),
//                                onPressed: () {
//                                  setState(() {
//                                    pwdShow = !pwdShow;
//                                  });
//                                }),
//                            prefixIcon: Icon(Icons.lock_outline)),
//                        onChanged: (val) {
//                          _password = val;
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              Container(
//                decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        begin: Alignment.bottomLeft,
//                        colors: [Colors.redAccent, Colors.orange]),
//                    borderRadius: BorderRadius.circular(20.0)),
//                child: FlatButton(
//                  child: Text("登录"),
//                  onPressed: () => _forSubmitted(context),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

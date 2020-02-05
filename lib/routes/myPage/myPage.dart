import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<void> clean() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    print('cleared');
  }

  void logout(){
     clean();
     Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "我",
        ),
      ),
      body: Column(
        children: <Widget>[
          InkWellContainer('/test', 'test'),

          InkWell(
            onTap: () => logout(),
            child: LogoutContainer(),
          ),

          InkWellContainer('/feedback', '反馈'),

        ],
      ),
    );
  }
}

class InkWellContainer extends StatefulWidget {
  String routeName;
  String funcName;

  InkWellContainer(this.routeName, this.funcName);

  @override
  _InkWellContainerState createState() => _InkWellContainerState();
}

class _InkWellContainerState extends State<InkWellContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, this.widget.routeName);
      },
      child: Container(
        height: 60,
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text(
                this.widget.funcName,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}

class LogoutContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              "切换账号",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}

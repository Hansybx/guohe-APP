import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/localShare.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextStyle whiteBoldText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.black38,
  );

  bool flag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag = SpUtil.getBool(LocalShare.AUTO_UPDATE, defValue: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '设置',
          style: new TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              AntDesign.back,
              color: Colors.black,
            ),
            tooltip: "back",
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                new Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/imgs/core/settings.png"),
                  ),
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                    "设置语言",
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    "English US",
                    style: greyTExt,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {},
                ),
//                ListTile(
//                  title: Text(
//                    "Profile Settings",
//                    style: whiteBoldText,
//                  ),
//                  subtitle: Text(
//                    "Jane Doe",
//                    style: greyTExt,
//                  ),
//                  trailing: Icon(
//                    Icons.keyboard_arrow_right,
//                    color: Colors.grey.shade400,
//                  ),
//                  onTap: () {},
//                ),
                SwitchListTile(
                  title: Text(
                    "启动时检查更新",
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    flag ? "On" : "false",
                    style: greyTExt,
                  ),
                  value: flag,
                  onChanged: (val) {
                    setState(() {
                      flag = val;
                    });
                    SpUtil.putBool(LocalShare.AUTO_UPDATE, flag);
                  },
                ),
//                SwitchListTile(
//                  title: Text(
//                    "Push Notifications",
//                    style: whiteBoldText,
//                  ),
//                  subtitle: Text(
//                    "Off",
//                    style: greyTExt,
//                  ),
//                  value: false,
//                  onChanged: (val) {},
//                ),
//                ListTile(
//                  title: Text(
//                    "Logout",
//                    style: whiteBoldText,
//                  ),
//                  onTap: () {},
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

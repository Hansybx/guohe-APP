import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/sp_file.dart';
import 'package:flutter_app/common/string_file.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/dialog.dart';
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
  String language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag = SpUtil.getBool(LocalShare.AUTO_UPDATE, defValue: true);
    language = SpUtil.getString(LocalShare.LANGUAGE, defValue: "简体中文");

//    if (language == "简体中文") S.load(Locale('zn', 'CN'));
//    if (language == "English") S.load(Locale('en', 'US'));
//    print(language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).setting,
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
                    child: Image.asset(StringFile.SETTING_PIC),
                  ),
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                    S.of(context).language,
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    language,
                    style: greyTExt,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (context) {
                          String selectValue = '';
                          List<String> valueList = ["简体中文", "English"];
                          return RadioAlertDialog(
                              showCancel: false,
                              showConfirm: false,
                              title: S.of(context).language,
                              selectValue: selectValue,
                              valueList: valueList);
                        }).then((value) {
                      print(value);
                      if (value != null) {
                        SpUtil.putString(LocalShare.LANGUAGE, value);
                        setState(() {
                          if (value == "简体中文") S.load(Locale('zn', 'CN'));
                          if (value == "English") S.load(Locale('en', 'US'));
                          language = value;
                        });
                      }
                    });
                  },
                ),
                SwitchListTile(
                  title: Text(
                    S.of(context).auto_update,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

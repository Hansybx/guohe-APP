import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/spFile.dart';
import 'package:flutter_app/common/stringFile.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextStyle greyText = TextStyle(
    color: Colors.black38,
  );

  final picker = ImagePicker();

  bool flag, classFlag;
  String language, schoolArea, imgBackground;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag = SpUtil.getBool(LocalShare.AUTO_UPDATE, defValue: true);
    classFlag = SpUtil.getBool(LocalShare.CLASS_VISIBLE, defValue: true);
    language = SpUtil.getString(LocalShare.LANGUAGE, defValue: "简体中文");
    schoolArea = SpUtil.getString(LocalShare.SCHOOLAREA, defValue: "长山");
  }

  Widget schoolAreaListTile() {
    return ListTile(
      title: Text(
        S.of(context).schoolAreaValue,
        style: whiteBoldText,
      ),
      subtitle: Text(
        schoolArea,
        style: greyText,
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
              List<String> valueList = ["梦溪", "长山"];
              return RadioAlertDialog(
                  showCancel: false,
                  showConfirm: false,
                  title: S.of(context).schoolAreaValue,
                  selectValue: selectValue,
                  valueList: valueList);
            }).then((value) {
          if (value != null) {
            SpUtil.putString(LocalShare.SCHOOLAREA, value);
            setState(() {
              schoolArea = value;
            });
          }
        });
      },
    );
  }

  Widget classVisibleSwitch() {
    return SwitchListTile(
      title: Text(
        S.of(context).class_visible,
//      "其它周次课程是否可见",
        style: whiteBoldText,
      ),
      subtitle: Text(
        classFlag ? "ON" : "OFF",
        style: greyText,
      ),
      value: classFlag,
      onChanged: (val) {
        setState(() {
          classFlag = val;
        });
        SpUtil.putBool(LocalShare.CLASS_VISIBLE, classFlag);
      },
    );
  }

  _uploadImg() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      imgBackground = image.path;
    });
    SpUtil.putString(LocalShare.BACKGROUND, imgBackground);
    showDialog(
      context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            content: Text(S.of(context).img_pick_tip),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () =>
                    Navigator.of(context).pop(), //关闭对话框
              ),
            ],
          );
        }
    );
  }

  Widget scheduleBackground() {
    return ListTile(
      title: Text(
        S.of(context).scheduleBackground,
        style: whiteBoldText,
      ),
      subtitle: Text(
        S.of(context).long_press_to_reset,
        style: greyText,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey.shade400,
      ),
      onTap: _uploadImg,
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(S.of(context).tips),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                content: Text(S.of(context).bg_img_reset),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      SpUtil.remove(LocalShare.BACKGROUND);
                      Navigator.of(context).pop();
                    }, //关闭对话框
                  ),
                ],
              );
            });
      },
    );
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
                    style: greyText,
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
                schoolAreaListTile(),
                scheduleBackground(),
                SwitchListTile(
                  title: Text(
                    S.of(context).auto_update,
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    flag ? "ON" : "OFF",
                    style: greyText,
                  ),
                  value: flag,
                  onChanged: (val) {
                    setState(() {
                      flag = val;
                    });
                    SpUtil.putBool(LocalShare.AUTO_UPDATE, flag);
                  },
                ),
                classVisibleSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

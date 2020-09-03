import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

/// 常用工具类
class CommonUtils {
  // 弹出toast
  static showToast(BuildContext context, String msg,
      {int duration, int gravity = 0}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  // 时间戳转时间
  static timeStamp2Time(int timeStamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timeStamp);
  }

//   时间戳描述
  static String timeStampDescribe(int timeStamp) {
    String result = "";
    var dateTimeStamp = new DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var now = new DateTime.now();
    var diffValue = now.difference(dateTimeStamp);
    var days = diffValue.inDays;
    var hours = diffValue.inHours;
    var minutes = diffValue.inMinutes;
    var seconds = diffValue.inSeconds;
    if (days >= 365) {
      result = (days ~/ 365).toString() + "年前";
    } else if (days >= 50 && days < 365) {
      result = (days ~/ 30).toString() + "月前";
    } else if (days > 1 && days < 50) {
      result = days.toString() + "天前";
    } else if (days == 1) {
      result = "昨天";
    } else if (days == 0) {
      if (hours != 0) {
        result = hours.toString() + "小时前";
      } else {
        if (minutes != 0) {
          result = minutes.toString() + "分钟前";
        } else {
          if (seconds > 2) {
            result = seconds.toString() + "秒前";
          } else {
            result = "刚刚";
          }
        }
      }
    }
    return result;
  }
}

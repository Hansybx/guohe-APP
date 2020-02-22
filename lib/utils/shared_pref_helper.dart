import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String kUserId = 'uid';
  static final String kUserEmail = 'uemail';
  static final String kUserName = 'uname';
  static final String kUserPass = 'upass';
  static final String kUserAvatar = 'avator';
  static final String kUserPhone = 'phone';
  static final String kUserGender = 'gender';
  static final String kUserBirth = 'birthday';

  ///-------------------------
  ///自定义一些方法
  ///------------------------

  static String getUserEmail(SharedPreferences prefs) {
    return prefs.containsKey(kUserEmail)
        ? prefs.getString(kUserEmail ?? '')
        : '';
  }

  static Future<bool> setUserEmail(String value, SharedPreferences prefs) {
    return prefs.setString(kUserEmail, value);
  }

  static String getUserGender(SharedPreferences prefs) {
    return prefs.containsKey(kUserGender)
        ? prefs.getString(kUserGender ?? '')
        : '';
  }

  static Future<bool> setUserGender(String value, SharedPreferences prefs) {
    return prefs.setString(kUserGender, value);
  }

  static String getUserBirth(SharedPreferences prefs) {
    return prefs.containsKey(kUserBirth)
        ? prefs.getString(kUserBirth ?? '')
        : '';
  }

  static Future<bool> setUserBirth(String value, SharedPreferences prefs) {
    return prefs.setString(kUserBirth, value);
  }

  static String getUserPhone(SharedPreferences prefs) {
    return prefs.containsKey(kUserPhone)
        ? prefs.getString(kUserPhone ?? '')
        : '';
  }

  static Future<bool> setUserPhone(String value, SharedPreferences prefs) {
    return prefs.setString(kUserPhone, value);
  }

  static String getUserId(SharedPreferences prefs) {
    return prefs.containsKey(kUserId) ? prefs.getString(kUserId ?? '') : '';
  }

  static Future<bool> setUserId(String value, SharedPreferences prefs) {
    return prefs.setString(kUserId, value);
  }

  static String getUserName(SharedPreferences prefs) {
    return prefs.containsKey(kUserName) ? prefs.getString(kUserName ?? '') : '';
  }

  static Future<bool> setUserName(String value, SharedPreferences prefs) {
    return prefs.setString(kUserName, value);
  }

  static String getUserPass(SharedPreferences prefs) {
    return prefs.containsKey(kUserPass) ? prefs.getString(kUserPass ?? '') : '';
  }

  static Future<bool> setUserPass(String value, SharedPreferences prefs) {
    return prefs.setString(kUserPass, value);
  }

  static String getUserAvatar(SharedPreferences prefs) {
    return prefs.containsKey(kUserAvatar)
        ? prefs.getString(kUserAvatar ?? '')
        : '';
  }

  static Future<bool> setUserAvatar(String value, SharedPreferences prefs) {
    return prefs.setString(kUserAvatar, value);
  }

  /// 切换账号时执行
  static Future<bool> logout(SharedPreferences prefs) {
    return prefs.clear();
  }

  ///-----------------
  ///Save boolean values
  ///------------------
  static bool getBoolean(String key, SharedPreferences prefs) {
    return prefs.containsKey(key) ? prefs.getBool(key ?? false) : false;
  }

  static Future<bool> saveBoolean(
      String key, bool value, SharedPreferences prefs) {
    return prefs.setBool(key, value);
  }

  ///--------------------------
  /// SAVE STRINGS
  ///--------------------------
  static String getString(String key, SharedPreferences prefs) {
    return prefs.getString(key ?? '');
  }

  static Future<bool> setString(
      String key, String value, SharedPreferences prefs) {
    return prefs.setString(key, value);
  }

  ///--------------------------
  /// SAVE INTEGERS
  ///--------------------------
  static int getInt(String key, SharedPreferences prefs) {
    return prefs.getInt(key ?? 0);
  }

  static Future<bool> setInt(String key, int value, SharedPreferences prefs) {
    return prefs.setInt(key, value);
  }

  ///--------------------------
  /// SAVE DOUBLE
  ///--------------------------
  static double getDouble(String key, SharedPreferences prefs) {
    return prefs.getDouble(key ?? 0.0);
  }

  static Future<bool> setDouble(
      String key, double value, SharedPreferences prefs) {
    return prefs.setDouble(key, value);
  }
}

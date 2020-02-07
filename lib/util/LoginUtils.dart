import 'dart:convert';

import 'package:netease_music/modal/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUtil {

  /// 处理登录成功后的逻辑
  static Future<bool> afterLoginSuccess(String phone, String passWord) async {
    UserInfo userInfo = new UserInfo(phone, passWord);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userInfo", json.encode(userInfo));
  }

}

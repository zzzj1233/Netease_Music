import 'package:flutter/cupertino.dart';
import 'package:netease_music/pages/Home/Home.dart';
import 'package:netease_music/pages/Home/RecommendDaily/RecommendDaily.dart';
import 'package:netease_music/pages/Home/SongList/SongList.dart';
import 'package:netease_music/pages/Login/LoginPage.dart';
import 'package:netease_music/pages/Login/PhoneLogin.dart';
import 'package:netease_music/pages/Login/PhoneLoginVerificationCode.dart';
import 'package:netease_music/pages/Login/PhonePassWordLogin.dart';
import 'package:netease_music/pages/Player/Player.dart';

class Routes {
  static const String LOGIN_PAGE = "/";

  static const String PHONE_LOGIN_PAGE = "login_phone";

  static const String PHONE_LOGIN_VERIFICATION_CODE_PAGE = "login_phone_code";

  static const String HOME_PAGE = "home";

  static const String PASSWORD_LOGIN_PAGE = "login_phone_password";

  static const String RECOMMEND_DAILY_PAGE = "recommend_daily";

  static const String SONG_LIST_PAGE = "song_list";

  static const String PLAYER_PAGE = "player";

  static final Map<String, WidgetBuilder> routes = {
    LOGIN_PAGE: (context) => LoginPage(),
    PHONE_LOGIN_PAGE: (context) => PhoneLogin(),
    PHONE_LOGIN_VERIFICATION_CODE_PAGE: (context) =>
        PhoneLoginVerificationCode(),
    HOME_PAGE: (context) => Home(),
    PASSWORD_LOGIN_PAGE: (context) => PhonePassWordLogin(),
    RECOMMEND_DAILY_PAGE: (context) => RecommendDaily(),
    SONG_LIST_PAGE: (context) => SongList(),
    PLAYER_PAGE: (context) => Player()
  };
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/pages/Home/Home.dart';
import 'package:netease_music/pages/Home/RecommendDaily/RecommendDaily.dart';
import 'package:netease_music/pages/Home/SongList/SongList.dart';
import 'package:netease_music/pages/Login/LoginPage.dart';
import 'package:netease_music/pages/Login/PhoneLogin.dart';
import 'package:netease_music/pages/Login/PhoneLoginVerificationCode.dart';
import 'package:netease_music/pages/Login/PhonePassWordLogin.dart';
import 'package:netease_music/provider/BlurImageModal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  final bool logged = await checkLogin();
  runApp(App(
    logged: logged,
  ));
}

Future<bool> checkLogin() async {
  /// 1. 先检查本地是否存有登录信息
  Api api = new Api();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userInfo = prefs.getString("userInfo");

  /// 2. 如果有,拿去登录,查看是否可以登录成功
  if (userInfo != null && userInfo.isNotEmpty) {
    bool loginSuccess = await api.login(userInfo);
    if (loginSuccess) {
      return true;
    } else {
      /// todo 登录失败,弹出信息,要求重新登录
//      BotToast.showText(text: "登录信息已过期,请重新登录");
      return false;
    }
  }
  return false;
}

class App extends StatelessWidget {
  final bool logged;

  App({Key key, this.logged}) : super(key: key);

  Api api = new Api();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: BotToastInit(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: ThemeData(fontFamily: "Microsoft YaHei"),
          routes: {
            "/": (context) => LoginPage(),
            "login_phone": (context) => PhoneLogin(),
            "login_phone_code": (context) => PhoneLoginVerificationCode(),
            "home": (context) => Home(),
            "login_phone_password": (context) => PhonePassWordLogin(),
            "recommend_daily": (context) => RecommendDaily(),
            "song_list": (context) => SongList(),
          },
        initialRoute: logged ? "home" : "/",
//          initialRoute: "recommend_daily",
        ),
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: BlurImageModal())
      ],
    );
  }
}

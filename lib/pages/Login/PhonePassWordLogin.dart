import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/util/LoginUtils.dart';

/// 输入验证码页面

class PhonePassWordLogin extends StatefulWidget {
  PhonePassWordLogin({Key key}) : super(key: key);

  @override
  _PhonePassWordLoginState createState() {
    return _PhonePassWordLoginState();
  }
}

class _PhonePassWordLoginState extends State<PhonePassWordLogin>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  Api api = Api();

  String _phone = null;

  String _phoneRex =
      '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$';

  TextEditingController passWordController = new TextEditingController();

  FocusNode focusNode = new FocusNode();

  String errorText = null;

  _handlePassWordLogin() async {
    final String passWord = this.passWordController.value.text;

    /// 空字符串
    if (passWord == null || passWord.trim().isEmpty) {
      this.animationController.forward();
      this.errorText = " ";
      return;
    }

    /// 密码长度不够
    if (passWord.trim().length < 6) {
      this.animationController.forward();
      this.errorText = "密码最少6位数";
      return;
    }

    /// 调用接口进行校验
    Response response = await api.phoneLogin(this._phone, passWord.trim());

    /// 登录成功
    if (response.data["code"] == 200) {
      /// 保存用户信息到本地,跳转至首页
      LoginUtil.afterLoginSuccess(this._phone, passWord.trim());

      Navigator.of(context).pushReplacementNamed("home");
    } else {
      /// 由于拦截器会弹出toast,在这里只需要处理后续逻辑
      /// 获取焦点
      print("密码错误");
      FocusScope.of(context).requestFocus(this.focusNode);
      this.animationController.forward();
      this.errorText = "密码输入错误";
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationController);

    animation.addStatusListener((AnimationStatus status) {
      /// 完成了再重复一次
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        this.setState(() {
          this.errorText = null;
        });
      }
    });
  }

  @override
  void dispose() {
    this.animationController.dispose();
    super.dispose();
  }

  /// 校验验证码
  verifyCode(String code) async {
    try {
      Response res = await this.api.verifyPhoneLoginCode(_phone, code);
      if (res == null) {
        /// 清空输入框
        this.passWordController.clear();

        /// 获取焦点
        FocusScope.of(context).requestFocus(focusNode);
        BotToast.showText(text: "验证码输入错误,请重新输入");
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, "/");
    }

    /// 请求成功后
    ///
    /// todo 判断用户是否已经注册过,如果注册过,登录成功,否则输入密码等
  }

  @override
  Widget build(BuildContext context) {
    /// 1. 先验证是否有传入过手机号
    Map<String, String> map =
        Map.from(ModalRoute.of(context).settings.arguments);

    if (map["phone"] == null || map["phone"].isEmpty) {
      Navigator.pushReplacementNamed(context, "/");
      return null;
    }

    /// 2. 正则验证
    if (!RegExp(_phoneRex).hasMatch(map["phone"])) {
      Navigator.pushReplacementNamed(context, "/");
      return null;
    }
    this._phone = map["phone"];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,

          /// 标题
          title: Text(
            "密码登录",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),

          /// 返回按钮
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            AnimatedBuilder(
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 24 + animation.value, right: 24 - animation.value),
                  child: TextField(
                    obscureText: true,
                    autofocus: true,
                    cursorColor: Colors.red,
                    controller: passWordController,
                    maxLength: 20,
                    focusNode: this.focusNode,
                    decoration: InputDecoration(
                        errorText: this.errorText,
                        hintText: "请输入密码",
                        suffixText: "忘记密码?",
                        suffixStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 9,
                        ),
                        hintStyle: TextStyle(fontSize: 12),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0))),
                  ),
                );
              },
              animation: this.animation,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              padding: EdgeInsets.only(left: 24, right: 24),
              height: 30,
              child: RaisedButton(
                color: Colors.red,
                child: Text("登录"),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(15)),
                onPressed: this._handlePassWordLogin,
              ),
            )
          ],
        ));
  }
}

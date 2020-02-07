import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/CountDownCode.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// 输入验证码页面

class PhoneLoginVerificationCode extends StatefulWidget {
  PhoneLoginVerificationCode({Key key}) : super(key: key);

  @override
  _PhoneLoginVerificationCodeState createState() {
    return _PhoneLoginVerificationCodeState();
  }
}

class _PhoneLoginVerificationCodeState
    extends State<PhoneLoginVerificationCode> {
  Api api = Api();

  String _phone = null;

  String _phoneRex =
      '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$';

  TextEditingController codeController = new TextEditingController();

  FocusNode focusNode = new FocusNode();

  GlobalKey<CountDownCodeState> countDownCodeStateKey = new GlobalKey();

  Timer timer;

  int time = 60;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this.timer?.cancel();
    this.timer = null;
    super.dispose();
  }

  /// 校验验证码
  verifyCode(String code) async {
    try {
      Response res = await this.api.verifyPhoneLoginCode(_phone, code);
      if (res == null) {
        /// 清空输入框
        this.codeController.clear();

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

    /// 3. 调用接口发送验证码
    api.sendPhoneLoginCode(map["phone"]).then((data) {
      if (data == null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    }).catchError((e) {
      Navigator.pushReplacementNamed(context, "/");
    });

    /// 4. 等待验证码发送到手机自动填写
    final Widget widget = Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,

          /// 标题
          title: Text(
            "手机号验证",
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: Text(
                  "验证码已发送至",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "+86 ${this._phone}",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      CountDownCode(
                        key: countDownCodeStateKey,
                        onPress: () {},
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                child: Center(
                    child: PinCodeTextField(
                  focusNode: focusNode,
                  controller: codeController,
                  length: 4,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.underline,
                  animationDuration: Duration(milliseconds: 300),
//                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  backgroundColor: ColorUtils.hexToColor("#FAFAFA"),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  textStyle: TextStyle(color: Colors.black),
                  onCompleted: this.verifyCode,
                  textInputType: TextInputType.number,
                  onChanged: (String value) {},
                )),
              ),
            ],
          ),
        ));

    /// 初始化定时器
    if (this.timer == null) {
      this.timer = Timer.periodic(Duration(seconds: 1), (t) {
        if (time <= 0) {
          this.timer.cancel();
          this.timer = null;
          countDownCodeStateKey.currentState.setTime(null);
        } else {
          countDownCodeStateKey.currentState.setTime(--time);
        }
      });
    }

    return widget;
  }
}

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/modal/CheckPhoneExistsModal.dart';

/// 输入手机号进行登录
class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  _PhoneLoginState createState() {
    return _PhoneLoginState();
  }
}

class _PhoneLoginState extends State<PhoneLogin> with TickerProviderStateMixin {
  AnimationController controller;
  TextEditingController textEditingController;

  final Api api = Api();

  String _phoneRex =
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';

  bool hasInputError = false;

  bool hasValue = false;



  @override
  void initState() {
    super.initState();

    /// 初始化动画相关类
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    textEditingController = new TextEditingController();
    textEditingController.addListener(() {
      if (this.textEditingController.value.text.isNotEmpty && !hasValue) {
        this.setState(() {
          this.hasValue = true;
        });
      } else {
        if (!hasValue) {
          this.setState(() {
            this.hasValue = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    this.controller.dispose();
    this.textEditingController.dispose();
    super.dispose();
  }

  _handleButtonPress() async {
    /// 空输入
    if (this.textEditingController.value.text.trim().isEmpty) {
      this.controller.forward();
      return;

      /// 格式不正确
    } else if (!RegExp(_phoneRex)
        .hasMatch(this.textEditingController.value.text.trim())) {
      BotToast.showText(text: "请输入正确的手机号");
      this.controller.forward();
    } else {
      final phone = this.textEditingController.value.text;

      /// 1. 判断这个手机号是否注册过
      CheckPhoneExistsModal checkPhoneExistsModal =
          await api.checkPhoneRegistered(phone);

      /// 2. 如果注册过,并且有密码,跳转至输入密码页面
      if (checkPhoneExistsModal.exist && checkPhoneExistsModal.hasPassword) {
        Navigator.of(context).pushReplacementNamed("login_phone_password",
            arguments: {"phone": phone});
        return;
      }

      /// 3. 如果没有注册过,跳转到输入验证码界面,进行用户注册
      Navigator.of(context).pushReplacementNamed("login_phone_code",
          arguments: {"phone": phone});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.forward) {
              this.setState(() {
                this.hasInputError = true;
              });
            } else if (status == AnimationStatus.dismissed) {
              this.hasInputError = false;
            }
          });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,

        /// 标题
        title: Text(
          "手机号登录",
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
          /// 提示文本
          Container(
            padding: EdgeInsets.only(left: 24),
            margin: EdgeInsets.only(top: 30),
            height: 20,
            width: double.infinity,
            child: Text(
              "未注册手机号登录后将自动创建账号",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          /// 输入框
          AnimatedBuilder(
            builder: (BuildContext context, Widget child) {
              return Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 40),
                  padding: EdgeInsets.only(
                      left: offsetAnimation.value + 24.0,
                      right: 24.0 - offsetAnimation.value),
                  child: Center(
                    child: TextField(
                      controller: textEditingController,
                      maxLength: 11,
                      cursorColor: Colors.red,
                      cursorWidth: 2,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixText: "+86  ",
                          prefixStyle: TextStyle(color: Colors.grey),
                          hintText: this.hasInputError ? "请输入正确的手机号" : "请输入手机号",
                          hintStyle: this.hasInputError
                              ? TextStyle(color: Colors.red)
                              : TextStyle(color: Colors.grey),
                          suffix: this.hasValue
                              ? InkWell(
                                  child: Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    this.textEditingController.clear();
                                  },
                                )
                              : null,
                          focusedBorder: hasInputError
                              ? UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                      style: BorderStyle.solid))

                              /// 隐藏输入框激活时的蓝线
                              : UnderlineInputBorder(
                                  borderSide: BorderSide(width: 0))),
                    ),
                  ));
            },
            animation: offsetAnimation,
          ),
          Container(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: FlatButton(
              child: Text(
                "下一步",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                this._handleButtonPress();
              },
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20))),
            ),
            height: 30,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}

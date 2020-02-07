import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool _agree = false;

  Api api = new Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.hexToColor("#C62F2F"),
        elevation: 0,
        brightness: Brightness.dark,
      ),
      body: SizedBox.expand(
        child: Container(
          color: ColorUtils.hexToColor("#C62F2F"),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 125,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: Container(
                  height: 50,
                  child: Image.asset(
                    "images/logo.png",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 190,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            /// 手机号登录
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: FlatButton(
                                color: Colors.white,
                                child: Text("手机号登录"),
                                textColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("login_phone");
                                },
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                            ),

                            /// 邮箱登录
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: FlatButton(
                                color: Colors.transparent,
                                child: Text("邮箱登录"),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.5, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {},
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                            ),

                            /// 联合登录
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 35,
                                    height: 35,
                                    child: Icon(
                                      FontAwesomeIcons.qq,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white12, width: 1)),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    child: Icon(
                                      FontAwesomeIcons.weixin,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white12, width: 1)),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    child: Icon(
                                      FontAwesomeIcons.weibo,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white12, width: 1)),
                                  ),
                                ],
                              ),
                            ),

                            /// 同意协议
                            Container(
                              width: double.infinity,
                              height: 30,
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        this.setState(() {
                                          this._agree = !this._agree;
                                        });
                                      },
                                      child: Container(
                                        child: this._agree
                                            ? Icon(
                                                Icons.check_box,
                                                size: 10,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank,
                                                size: 10,
                                                color: Colors.white54,
                                              ),
                                        margin:
                                            EdgeInsets.only(top: 0, right: 5),
                                      )),
                                  Text(
                                    "同意",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 8),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "《用户手册》",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  Text(
                                    "《隐私政策》",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  Text(
                                    "《儿童隐私政策》",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

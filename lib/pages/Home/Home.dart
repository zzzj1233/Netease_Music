import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:netease_music/pages/Home/Discover.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Mime.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = new TabController(length: 2, vsync: this);
    this.tabController.index = 1;
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
//    BotToast.showEnhancedWidget(
//        toastBuilder: (CancelFunc cancelFunc) {
//          return Container(
//            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - 50),
//            height: 50,
//            color: Colors.red,
//          );
//        },
//        crossPage: true,
//        allowClick: true,
//        clickClose: false,
//        duration: null);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future logout(BuildContext buildContext) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("userInfo");
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.hexToColor("#FAFAFA"),
        elevation: 0,
        brightness: Brightness.light,
        title: TabBar(
          isScrollable: true,
          controller: tabController,
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          indicatorColor: Colors.transparent,
          indicatorWeight: 0.0001,
          tabs: <Widget>[
            new Container(
              width: (MediaQuery.of(context).size.width -
                      (0.55 * MediaQuery.of(context).size.width)) /
                  2,
              child: new Tab(text: '我的'),
            ),
            new Container(
              width: (MediaQuery.of(context).size.width -
                      (0.55 * MediaQuery.of(context).size.width)) /
                  2,
              child: new Tab(text: '发现'),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.dehaze,
            color: Colors.black54,
          ),
          onPressed: () {
            this.logout(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.search, color: Colors.black54),
          )
        ],
      ),
      body: TabBarView(
        controller: this.tabController,
        children: <Widget>[
          Mime(),
          Discover(),
        ],
      ),
    );
  }
}

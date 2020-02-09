import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netease_music/components/CompactDisc.dart';
import 'package:netease_music/components/CustomAppBar.dart';
import 'package:netease_music/modal/PlaySong.dart';
import 'package:netease_music/provider/PlayerModal.dart';
import 'package:netease_music/util/DateUtils.dart';
import 'package:netease_music/util/IconFontUtils.dart';
import 'package:netease_music/util/ImageUtils.dart';
import 'package:provider/provider.dart';

/// 播放器页面

class Player extends StatefulWidget {
  Player({Key key}) : super(key: key);

  @override
  _PlayerState createState() {
    return _PlayerState();
  }
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
  AnimationController animationController;

  bool isPlay = true;

  @override
  void initState() {
    /// 创建动画控制器
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 15));

    this.animationController.repeat();

    /// 初始化音乐播放器
    super.initState();
  }

  @override
  void dispose() {
    this.animationController.dispose();
    super.dispose();
  }

  Widget buildBlurImage(String url) {
    if (url == null) {
      return ImageUtils.defaultBlurImage(
          BoxFit.cover, double.infinity, double.infinity);
    } else {
      return Image.network(url,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: Consumer<PlayerModal>(builder: (context, playerModal, child) {
      PlaySong song = playerModal.currentSong;
      return Stack(
        children: <Widget>[
          buildBlurImage(song?.coverUrl),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black87.withOpacity(.3),
              child: Column(
                children: <Widget>[
                  CustomAppBar(
                    titleWidget: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            song?.songName ?? "未知",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(40)),
                          ),
                          Text(
                            song?.singerName ?? "未知",
                            style:
                                TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: ScreenUtil().setSp(72),
                      )
                    ],
                  ),

                  /// 唱碟留白区
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
                    width: ScreenUtil().setWidth(700),
                    height: ScreenUtil().setWidth(700),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10.withOpacity(.2),
                    ),
                    child: CompactDisc(
                      animationController: this.animationController,
                      imageUrl: song?.coverUrl == null ? null : song.coverUrl + ImageUtils.getSmallImageSuffix(500),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        /// 五个按钮
                        Positioned(
                          bottom: ScreenUtil().setHeight(390),
                          left: 0,
                          right: 0,
                          child: Container(
                            height: ScreenUtil().setHeight(90),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white.withOpacity(.4),
                                  size: ScreenUtil().setSp(60),
                                ),
                                Icon(
                                  IconFontUtils.getIcon("xe603"),
                                  size: ScreenUtil().setSp(60),
                                  color: Colors.white.withOpacity(.4),
                                ),
                                Icon(
                                  IconFontUtils.getIcon("xe642"),
                                  color: Colors.white.withOpacity(.4),
                                  size: ScreenUtil().setSp(60),
                                ),
                                Icon(
                                  IconFontUtils.getIcon("xe751"),
                                  color: Colors.white.withOpacity(.4),
                                  size: ScreenUtil().setSp(60),
                                ),
                                Icon(
                                  IconFontUtils.getIcon("xe644"),
                                  color: Colors.white.withOpacity(.4),
                                  size: ScreenUtil().setSp(60),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 进度条和时间
                        Positioned(
                          bottom: ScreenUtil().setHeight(270),
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            height: ScreenUtil().setHeight(60),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /// 当前播放时间
                                StreamBuilder<int>(
                                  stream: playerModal.durationStream,
                                  builder: (context, snap) {
                                    String timeStr = snap.data == null
                                        ? "00:00"
                                        : DateUtils.formatSecond(snap.data);
                                    return Text(
                                      timeStr,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5),
                                          fontSize: ScreenUtil().setSp(33)),
                                    );
                                  },
                                ),

                                /// 播放进度条
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    child: Center(
                                        child: StreamBuilder<int>(
                                      stream: playerModal.durationStream,
                                      builder: (context, snap) {
                                        double value = snap.data != null
                                            ? snap.data.toDouble()
                                            : 0.0;
                                        return Slider(
                                          value: value,
                                          onChanged: (double value) {
                                            print(value);
                                          },
                                          min: 0.0,
                                          max: 246,
                                          inactiveColor:
                                              Colors.grey.withOpacity(.5),
                                          activeColor:
                                              Colors.white.withOpacity(.8),
                                        );
                                      },
                                    )),
                                  ),
                                ),

                                /// 播放总时长
                                Text(
                                  DateUtils.formatSecond(song?.duration ?? 0),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: ScreenUtil().setSp(33)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 播放控制按钮
                        Positioned(
                          bottom: ScreenUtil().setHeight(90),
                          left: 0,
                          right: 0,
                          child: Container(
                            height: ScreenUtil().setHeight(120),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /// 循环播放: xe6a2
                                  /// 列表播放: xea77
                                  Icon(
                                    IconFontUtils.getIcon("xea77"),
                                    color: Colors.white.withOpacity(.8),
                                    size: ScreenUtil().setSp(60),
                                  ),
                                  Icon(
                                    IconData(0xe604, fontFamily: "iconfont"),
                                    color: Colors.white.withOpacity(.8),
                                    size: ScreenUtil().setSp(60),
                                  ),

                                  /// 暂停 0xe7c6
                                  InkWell(
                                    child: Icon(
                                      buildPlayIcon(),
                                      color: Colors.white.withOpacity(.8),
                                      size: ScreenUtil().setSp(120),
                                    ),
                                    onTap: () {
                                      this.play(playerModal);
                                    },
                                  ),
                                  Icon(
                                    IconFontUtils.getIcon("xe620"),
                                    color: Colors.white.withOpacity(.8),
                                    size: ScreenUtil().setSp(60),
                                  ),
                                  Icon(
                                    IconFontUtils.getIcon("xe600"),
                                    color: Colors.white.withOpacity(.8),
                                    size: ScreenUtil().setSp(60),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }));
  }

  IconData buildPlayIcon() {
    return this.isPlay
        ? IconFontUtils.getIcon("xe7c6")
        : IconFontUtils.getIcon("xe601");
  }

  void play(PlayerModal playerModal) {
    this.setState(() {
      this.isPlay = !this.isPlay;

      /// 暂停
      if (!this.isPlay) {
        this.animationController.stop();
        playerModal.pause();

        /// 播放
      } else {
        this.animationController.repeat();
        playerModal.resume();
      }
    });
  }
}

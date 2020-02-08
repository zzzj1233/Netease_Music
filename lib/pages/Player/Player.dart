import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netease_music/components/CompactDisc.dart';
import 'package:netease_music/components/CustomAppBar.dart';
import 'package:netease_music/modal/PlaySong.dart';
import 'package:netease_music/provider/PlayerModal.dart';
import 'package:netease_music/util/DateUtils.dart';
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
                      margin: EdgeInsets.only(left: 10),
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
                                fontSize: 13),
                          ),
                          Text(
                            song?.singerName ?? "未知",
                            style: TextStyle(fontSize: 10, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 16,
                      )
                    ],
                  ),

                  /// 唱碟留白区
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10.withOpacity(.2),
                    ),
                    child: CompactDisc(
                      animationController: this.animationController,
                      imageUrl: song?.coverUrl,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        /// 五个按钮
                        Positioned(
                          bottom: 100,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white.withOpacity(.4),
                                  size: 18,
                                ),
                                Icon(
                                  IconData(0xe502, fontFamily: 'iconfont'),
                                  size: 18,
                                  color: Colors.white.withOpacity(.4),
                                ),
                                IconButton(
                                  icon: Icon(
                                    IconData(0xe642, fontFamily: 'iconfont'),
                                    color: Colors.white.withOpacity(.4),
                                    size: 18,
                                  ),
                                  onPressed: () {},
                                ),
                                Icon(
                                  FontAwesomeIcons.commentDots,
                                  color: Colors.white.withOpacity(.4),
                                  size: 18,
                                ),
                                Icon(
                                  IconData(0xe63f, fontFamily: 'iconfont'),
                                  color: Colors.white.withOpacity(.4),
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 进度条和时间
                        Positioned(
                          bottom: 60,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
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
                                          fontSize: 11),
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
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 播放控制按钮
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /// 循环播放: 0xe606
                                  /// 列表播放: 0xea77
                                  Icon(
                                    IconData(0xea77, fontFamily: 'iconfont'),
                                    color: Colors.white.withOpacity(.8),
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe507, fontFamily: 'iconfont'),
                                    color: Colors.white.withOpacity(.8),
                                    size: 18,
                                  ),

                                  /// 暂停 0xe7c6
                                  IconButton(
                                    icon: Icon(
                                      buildPlayIcon(),
                                      color: Colors.white.withOpacity(.8),
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      this.play(playerModal);
                                    },
                                  ),
                                  Icon(
                                    IconData(0xe620, fontFamily: 'iconfont'),
                                    color: Colors.white.withOpacity(.8),
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe570, fontFamily: 'iconfont'),
                                    color: Colors.white.withOpacity(.8),
                                    size: 18,
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
        ? IconData(0xe7c6, fontFamily: 'iconfont')
        : IconData(0xe601, fontFamily: 'iconfont');
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

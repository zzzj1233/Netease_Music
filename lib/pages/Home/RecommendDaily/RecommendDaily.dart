import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/components/PlayList.dart';
import 'package:netease_music/components/PlayListHeader.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/util/ImageUtils.dart';

/// 每日推荐组件

class RecommendDaily extends StatefulWidget {
  RecommendDaily({Key key}) : super(key: key){
  }

  @override
  _RecommendDailyState createState() {
    return _RecommendDailyState();
  }
}

class _RecommendDailyState extends State<RecommendDaily> {
  Api api = new Api();

  List<Song> songs;

  bool initialized = false;

  /// 用于content背景图片Url和虚焦Url
  String imageUrl = ImageUtils.url();

  Random random = new Random();

  @override
  void initState() {
    /// 设置状态栏颜色透明
    this.initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 请求推荐每日推荐歌曲
  void initData() async {
    this.songs = await api.recommendSongs();
    if (this.songs.length > 0) {
      this.imageUrl = songs[random.nextInt(this.songs.length)].coverUrl;
    }
    if (mounted) {
      this.setState(() {
        this.initialized = true;
      });
    }
  }

  @override
  void deactivate() {
    /// 如果上一个route需要设置状态栏颜色,则回调
//    if (ModalRoute.of(context).settings.arguments is Function) {
//      Function function = ModalRoute.of(context).settings.arguments;
//      function();
//    }
    super.deactivate();
  }

  Widget buildPlayListContent() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(this.imageUrl), fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!this.initialized) {
      return Loading();
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: PlayList(
          musicListHeader: MusicListHeader(
            onTap: () {},
            songListCount: this.songs.length,
            showCount: true,
          ),
          title: Text(
            "每日推荐",
            style: TextStyle(fontSize: 14),
          ),
          leading: IconButton(
            icon: BackButtonIcon(),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            iconSize: 14,
          ),
          content: buildPlayListContent(),
          blurImage: this.imageUrl,
          songList: this.songs,
          sigmaY: 20,
          sigmaX: 20,
        ),
      ),
    );
  }
}

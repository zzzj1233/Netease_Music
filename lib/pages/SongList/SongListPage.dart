import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/components/MusicListHeader/impl/SongListHeader.dart';
import 'package:netease_music/components/PlayList.dart';
import 'package:netease_music/components/SongListContent.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/modal/SongList.dart';
import 'package:netease_music/support/PlayListSongDisplayMode.dart';
import 'package:netease_music/util/ImageUtils.dart';

/// 歌单通用页面
class SongListDetailPage extends StatefulWidget {
  SongListDetailPage({Key key}) : super(key: key);

  @override
  _SongListDetailPageState createState() {
    return _SongListDetailPageState();
  }
}

class _SongListDetailPageState extends State<SongListDetailPage> {
  int _songListId;

  bool initialized = false;

  SongList songList;

  List<Song> songs = [];

  Api api = new Api();

  @override
  void initState() {
    super.initState();
  }

  void initData() async {
    print("init data!!!!");

    /// 从路由中获取ID参数
    if (!(ModalRoute.of(context).settings.arguments is Map)) {
      BotToast.showText(text: "错误的请求");
      Navigator.of(context).pop();
      return;
    }

    Map map = ModalRoute.of(context).settings.arguments;

    if (map["id"] == null || !(map["id"] is int) || map["id"] < 0) {
      BotToast.showText(text: "错误的请求");
      Navigator.of(context).pop();
      return;
    }

    this._songListId = map["id"];

    this.songList = await api.selectSongListById(_songListId);

    this
        .songList
        .songs
        .forEach((item) => this.songs.add(Song.fromSongListSong(item)));

    this.setState(() {
      this.initialized = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!this.initialized) {
      this.initData();
    }

    if (!this.initialized) {
      return Scaffold(
        body: Loading(),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: PlayList(
            expandHeight: 250,
            songList: this.songs,
            title: Text("歌单"),
            musicListHeader: SongListHeader(
              collectCount: this.songList.subscribedCount,
              onTap: () {},
              subscribed: this.songList.subscribed,
              showCount: true,
              songListCount: this.songList.length,
            ),
            content: SongListContent(
              songList: this.songList,
            ),
            blurImage:
                this.songList.coverImgUrl + ImageUtils.getSmallImageSuffix(200),
            sigmaX: 30,
            sigmaY: 30,
            httpBlurImage: true,
            mode: PlayListSongDisplayMode.RANK,
          ),
        ));
  }
}

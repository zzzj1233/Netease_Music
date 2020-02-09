import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/provider/PlayerModal.dart';
import 'package:netease_music/route/Routes.dart';
import 'package:netease_music/support/PlayListSongDisplayMode.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:netease_music/util/IconFontUtils.dart';
import 'package:netease_music/util/ImageUtils.dart';
import 'package:netease_music/util/PlayerUtils.dart';
import 'package:provider/provider.dart';

import 'FlexibleDetailBar.dart';
import 'MusicListHeader/MusicListHeader.dart';

/// 每日推荐

class PlayList extends StatelessWidget {
  final MusicListHeader musicListHeader;

  final List<Song> songList;

  final Widget title;

  final Widget content;

  final bool centerTitle;

  final String blurImage;

  final bool httpBlurImage;

  final double sigmaY;

  final double sigmaX;

  final Widget leading;

  final double expandHeight;

  final PlayListSongDisplayMode mode;

  const PlayList(
      {Key key,
      @required this.musicListHeader,
      @required this.songList,
      @required this.title,
      @required this.content,
      this.centerTitle = false,
      @required this.blurImage,
      this.sigmaY = 10,
      this.sigmaX = 10,
      this.leading,
      this.httpBlurImage = true,
      this.expandHeight,
      this.mode = PlayListSongDisplayMode.IMAGE})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          snap: false,
          title: this.title,
          leading: this.leading ?? BackButton(),
          flexibleSpace: FlexibleDetailBar(
            background: Stack(
              children: <Widget>[
                httpBlurImage
                    ? CachedNetworkImage(
                        imageUrl: this.blurImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) {
                          return ImageUtils.defaultBlurImage(
                              BoxFit.fill, double.infinity, double.infinity);
                        },
                      )
                    : Image.asset(
                        this.blurImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),

                /// 背景虚焦
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: this.sigmaY,
                    sigmaX: this.sigmaX,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),

            /// 使用外部传入的content
            content: content,
          ),
          expandedHeight: this.expandHeight ?? 160,
          bottom: this.musicListHeader,
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: _Song(
                  song: this.songList[index],
                  mode: this.mode,
                  index: index,
                ),
              );
            },
            childCount: this.songList.length,
          ),
          itemExtent: 50,
        )
      ],
    );
  }
}

class _Song extends StatelessWidget {
  final Song song;

  final PlayListSongDisplayMode mode;

  final int index;

  _Song({Key key, this.song, this.mode, this.index}) : super(key: key);

  void playSong(BuildContext context) {
    PlayerUtils.playSongFromSong(
        this.song, Provider.of<PlayerModal>(context, listen: false));
    Navigator.pushNamed(context, Routes.PLAYER_PAGE);
  }

  List<Widget> buildIconAndSingerName() {
    List<Widget> result = [];

    /// 为歌曲可用做颜色判断
    if (song.playable) {

      if (song.vip) {
        result.add(Container(
          width: 20,
          child: Icon(
            IconFontUtils.getIcon2("xe628"),
            size: 16,
            color: Colors.red,
          ),
        ));
      }

      if (song.private) {
        result.add(Container(
          width: 20,
          child: Icon(
            IconFontUtils.getIcon("xe605"),
            size: 10,
            color: Colors.red,
          ),
        ));
      }

      if (song.hq) {
        result.add(Container(
          width: 20,
          child: Icon(
            IconFontUtils.getIcon("xe79f"),
            size: 13,
            color: Colors.red,
          ),
        ));

      }

      result.add(Expanded(
        child: Container(
          child: Text(
            "${this.song.singerName} - ${this.song.albumName}",
            style: TextStyle(color: Colors.grey, fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ));
    } else {
      result.add(Expanded(
        child: Container(
          child: Text(
            "${this.song.singerName} - ${this.song.albumName}",
            style: TextStyle(color: ColorUtils.lightGrey(), fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ));
    }

    return result;
  }

  Widget buildPlayMvIcon(BuildContext context){
    if (song.vip || !(song.playable)) {
      return Container();
    }  else{
      return InkWell(
        child: Container(
          width: 30,
          child: Center(
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.transparent,
                    border: Border.all(
                        color: ColorUtils.lightGrey(), width: 1),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ))),
        ),
        onTap: () {
          this.playSong(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Builder(
              builder: (context) {
                /// 构建歌曲图片,或者123456...的数字排序
                if (this.mode == PlayListSongDisplayMode.IMAGE) {
                  return Container(
                      padding: EdgeInsets.only(right: 20),
                      height: 40,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          song.smallCoverUrl,
                          fit: BoxFit.cover,
                        ),
                      ));
                } else {
                  return Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ));
                }
              },
            ),
            Expanded(
                flex: 1,

                /// 歌名和歌手
                child: InkWell(
                  onTap: () {
                    if (song.playable && !(song.vip)) {
                      this.playSong(context);
                    } else {
                      /// todo 歌曲不可播放
                      if (song.vip) {

                      }  else{

                      }
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Builder(
                        builder: (context) {
                          TextStyle style;
                          if (!song.playable) {
                            style = TextStyle(color: ColorUtils.lightGrey());
                          }
                          return Container(
                            height: 26,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              this.song.songName,
                              style: style,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                      Container(
                        height: 14,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,

                          /// 构建SQ,独家图标和歌手+专辑名
                          children: buildIconAndSingerName(),
                        ),
                      ),
                    ],
                  ),
                )),

            /// 播放按钮
            buildPlayMvIcon(context),

            /// 查看歌曲详情按钮
            Container(
              width: 30,
              child: Icon(
                Icons.format_align_left,
                color: Colors.grey,
                size: 15,
              ),
            )
          ],
        ));
  }
}

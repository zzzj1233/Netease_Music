import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:netease_music/util/ImageUtils.dart';

import 'FlexibleDetailBar.dart';
import 'PlayListHeader.dart';

/// 歌单,播放列表,每日推荐的公用页面

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
      this.expandHeight})
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
                ),
              );
            },
            childCount: 20,
          ),
          itemExtent: 50,
        )
      ],
    );
  }
}

class _Song extends StatelessWidget {
  final Song song;

  _Song({Key key, this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 20),
                height: 40,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    song.coverUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 26,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 8),
                      child: Text(this.song.songName,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      height: 14,
                      width: double.infinity,
                      child: Text(
                        "${this.song.singerName}   -   ${this.song.albumName}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
            Container(
              width: 30,
              child: Center(
                  child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.transparent,
                        border:
                            Border.all(color: ColorUtils.lightGrey(), width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ))),
            ),
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

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/modal/Song.dart';

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
                    ? Image.network(
                        this.blurImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        this.blurImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),

                /// 背景虚焦
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: this.sigmaY,
                    sigmaX: this.sigmaX,
                  ),
                  child: Container(
                    color: Colors.black38,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            /// 使用外部传入的content
            content: content,
          ),
          expandedHeight: this.expandHeight ?? 120,
          bottom: this.musicListHeader,
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 50,
                child: Center(
                  child: Text((index + 1).toString()),
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

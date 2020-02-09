import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/components/CommonImage.dart';
import 'package:netease_music/components/PlayCount.dart';
import 'package:netease_music/modal/SongList.dart';
import 'package:netease_music/util/IconFontUtils.dart';
import 'package:netease_music/util/ImageUtils.dart';

/// 歌单页面的头部Content
class SongListContent extends StatelessWidget {

  final SongList songList;

  const SongListContent({Key key, this.songList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: <Widget>[
          /// 背景虚焦
          CachedNetworkImage(
            imageUrl: this.songList.coverImgUrl + ImageUtils.getSmallImageSuffix(200),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Image.asset(
                ImageUtils.defaultBlurImageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY:40),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.only(top: 62, bottom: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: <Widget>[
                    /// 图片和歌单信息
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              width: 100,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  ///  歌单封面
                                  ClipRRect(
                                    child: CommonImage(
                                      url: this.songList.coverImgUrl + ImageUtils.getSmallImageSuffix(200),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: double.infinity,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  /// 播放次数
                                  PlayCount(
                                    count: this.songList.playCount,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    /// 歌单名称
                                    Container(
                                      height: 30,
                                      width: double.infinity,
                                      child: Text(
                                      this.songList.name,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    /// 创建者头像 + 创建者名字 + 箭头 ,
                                    InkWell(
                                      child: Container(
                                        margin:
                                        EdgeInsets.symmetric(vertical: 5),
                                        padding: EdgeInsets.only(right: 3),
                                        width: double.infinity,
                                        height: 25,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    this.songList.creator.avatarUrl +
                                                        ImageUtils
                                                            .getSmallImageSuffix(
                                                            25)),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              constraints: BoxConstraints(
                                                  maxWidth: 80
                                              ),
                                              child: Text(
                                                this.songList.creator.nickname,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(.8),
                                                    fontSize: 12
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white.withOpacity(
                                                  .8),
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// 歌单描述
                                    InkWell(
                                      onTap: (){},
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          this.songList.description??"",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontSize: 9
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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

                    /// 4个可操作图标
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        /// 评论
                        _IconTextButton(
                          icon: IconFontUtils.getIcon("xe751"),
                          title: this.songList.commentCount.toString(),
                        ),
                        /// 分享
                        _IconTextButton(
                          icon: IconFontUtils.getIcon2("xe618"),
                          title: this.songList.shareCount.toString(),
                        ),
                        _IconTextButton(
                          icon: IconFontUtils.getIcon("xe603"),
                          title: "下载",
                        ),
                        _IconTextButton(
                          icon: IconFontUtils.getIcon("xe607"),
                          title: "多选",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _IconTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _IconTextButton({Key key, this.title, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
      },
      child: Column(
        children: <Widget>[
          Icon(
            this.icon,
            color: Colors.white,
            size: 18,
          ),
          Container(
            height: 5,
          ),
          Text(
            this.title,
            style: TextStyle(color: Colors.white, fontSize: 8),
          )
        ],
      ),
    );
  }
}

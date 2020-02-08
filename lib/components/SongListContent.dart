import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/util/ImageUtils.dart';

/// 歌单页面的头部Content
class SongListContent extends StatelessWidget {
  final String imageUrl;

  SongListContent({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: this.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Image.asset(
                ImageUtils.defaultBlurImageUrl, width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,);
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Text("123"),
            ),
          )
        ],
      ),
    );
  }
}

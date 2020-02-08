import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/util/ImageUtils.dart';
import 'package:netease_music/util/NumberUtils.dart';

class SongListItem extends StatelessWidget {
  String picUrl;
  String title;
  int id;
  int updateTime;
  int playCount;
  String smallPicUrl;

  SongListItem(
      {Key key,
      this.picUrl,
      this.title,
      this.id,
      this.updateTime,
      this.playCount})
      : super(key: key) {
    this.smallPicUrl =
        picUrl == null ? null : picUrl + ImageUtils.smallImageSuffix;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Container(
              height: 100,
              width: 100,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(this.smallPicUrl, fit: BoxFit.fill),
                  ),
                  Positioned(
                    right: 5,
                    top: 2,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          size: 8,
                          color: Colors.white,
                        ),
                        Text(
                          NumberUtils.int2chineseNum(playCount),
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              "  " + title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/route/Routes.dart';
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
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.SONG_LIST_DETAIL,
              arguments: {"id": id});
        },
        splashColor: Colors.purpleAccent.withOpacity(.2),
        child: Column(
          children: <Widget>[
            Container(
                height: ScreenUtil().setWidth(300),
                width: ScreenUtil().setHeight(300),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(this.smallPicUrl, fit: BoxFit.fill),
                    ),
                    Positioned(
                      right: ScreenUtil().setWidth(15),
                      top: ScreenUtil().setHeight(6),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            size: ScreenUtil().setSp(24),
                            color: Colors.white,
                          ),
                          Text(
                            NumberUtils.int2chineseNum(playCount),
                            style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
              child: Text(
                "  " + title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(29),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

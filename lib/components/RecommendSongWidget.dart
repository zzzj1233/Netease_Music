import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/provider/PlayerModal.dart';
import 'package:netease_music/route/Routes.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:netease_music/util/PlayerUtils.dart';
import 'package:provider/provider.dart';

class RecommendSongWidget extends StatelessWidget {
  final Song recommendSong;

  RecommendSongWidget({Key key, this.recommendSong}) : super(key: key);

  void playSong(BuildContext context) {
    PlayerUtils.playSongFromSong(this.recommendSong, Provider.of<PlayerModal>(context,listen: false));
    Navigator.pushNamed(context, Routes.PLAYER_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.playSong(context);
      },
      child: Container(
          height: ScreenUtil().setHeight(120),
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(6)),
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(60)),
                  height: ScreenUtil().setHeight(120),
                  width: ScreenUtil().setWidth(180),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      recommendSong.smallCoverUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              /// 歌名和歌手名
              Expanded(
                  flex: 1,
                  child: Container(child: LayoutBuilder(
                    builder: (c, box) {
                      return Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: this.recommendSong.songName,
                              style: TextStyle(fontSize: ScreenUtil().setSp(36))),
                          TextSpan(
                            text: "  -  ${this.recommendSong.singerName}",
                            style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
                          ),
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ))),
              /// 播放按钮
              Container(
                width: ScreenUtil().setWidth(180),
                child: Center(
                    child: Container(
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setWidth(60),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border:
                          Border.all(color: ColorUtils.lightGrey(), width: 1),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.red,
                            size: ScreenUtil().setSp(45),
                          ),
                        ))),
              )
            ],

          )),
    );
  }
}

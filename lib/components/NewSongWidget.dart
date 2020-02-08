import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/modal/NewSongInfo.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/provider/PlayerModal.dart';
import 'package:netease_music/route/Routes.dart';
import 'package:netease_music/util/ColorsUtils.dart';
import 'package:netease_music/util/PlayerUtils.dart';
import 'package:provider/provider.dart';

class NewSongWidget extends StatelessWidget {
  final NewSongInfo newSongInfo;

  NewSongWidget({Key key, this.newSongInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.playSong(context);
      },
      child: Container(
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
                      newSongInfo.smallPicUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 40,
                      child: LayoutBuilder(
                        builder: (c, box) {
                          return Column(
                            children: <Widget>[
                              Container(
                                width: box.maxWidth,
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text: this.newSongInfo.songName,
                                        style: TextStyle(fontSize: 12)),
                                    TextSpan(
                                      text: "  -  ${this.newSongInfo.singerName}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: box.maxWidth,
                                child: Text(
                                  this.newSongInfo.alias ?? "",
                                  style:
                                  TextStyle(fontSize: 8, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          );
                        },
                      ))),
              Container(
                width: 60,
                child: Center(
                    child: Container(
                        width: 20,
                        height: 20,
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
                            size: 15,
                          ),
                        ))),
              )
            ],
          )),
    );
  }

  void playSong(BuildContext context) {
    PlayerUtils.playSongFromNewSong(this.newSongInfo, Provider.of<PlayerModal>(context,listen: false));
    Navigator.pushNamed(context, Routes.PLAYER_PAGE);
  }
}

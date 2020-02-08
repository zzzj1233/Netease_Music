import 'package:flutter/material.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class RecommendSongWidget extends StatelessWidget {
  final Song recommendSong;

  RecommendSongWidget({Key key, this.recommendSong}) : super(key: key);

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
                    recommendSong.smallCoverUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(child: LayoutBuilder(
                  builder: (c, box) {
                    return Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: this.recommendSong.songName,
                            style: TextStyle(fontSize: 12)),
                        TextSpan(
                          text: "  -  ${this.recommendSong.singerName}",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
        ));
  }
}

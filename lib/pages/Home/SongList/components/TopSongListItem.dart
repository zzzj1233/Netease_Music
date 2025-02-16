import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/components/CommonImage.dart';
import 'package:netease_music/components/PlayCount.dart';
import 'package:netease_music/components/SongListItem.dart';
import 'package:netease_music/route/Routes.dart';
import 'package:netease_music/util/NumberUtils.dart';

class TopSongListItem extends StatelessWidget {
  final SongListItem song;

  TopSongListItem({Key key, @required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.SONG_LIST_DETAIL,
            arguments: {"id": song.id});
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 118,
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CommonImage(
                            url: song.smallPicUrl,
                            fit: BoxFit.cover,
                            width: constraint.maxWidth,
                          ),
                        );
                      },
                    )),
                PlayCount(
                  count: song.playCount,
                )
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 33,
                  width: constraints.maxWidth,
                  child: Text(
                    song.title,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

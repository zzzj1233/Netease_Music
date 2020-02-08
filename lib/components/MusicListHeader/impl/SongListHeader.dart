import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:netease_music/components/MusicListHeader/MusicListHeader.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class SongListHeader extends MusicListHeader {
  final int songListCount;

  final VoidCallback onTap;

  final bool showCount;

  final bool subscribed;

  final int collectCount;

  const SongListHeader({
    Key key,
    this.collectCount,
    this.songListCount = 0,
    @required this.onTap,
    this.showCount = false,
    @required this.subscribed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(20);

  Widget buildCollectWidget() {
    if (this.subscribed) {
      return Container(
          height: 30,
          child: Row(
            children: <Widget>[
              Icon(Icons.insert_drive_file,color: Colors.grey,size: 10,),
              Container(width: 5,),
              Text(this.collectCount.toString(),style:TextStyle(
                color: Colors.grey,
                fontSize: 10
              ),)
            ],
          ));
    } else {
      return Container(
          height: 30,
          width: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FlatButton(
              onPressed: () {},
              color: Color.fromRGBO(255, 0, 0, 1),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "+ 收藏(${this.collectCount})",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              splashColor: ColorUtils.hexToColor("#DC143C"),
              highlightColor: ColorUtils.hexToColor("#DC143C"),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
          color: Colors.white,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: Row(
            children: <Widget>[
              InkWell(
                onTap: this.onTap,
                child: Icon(
                  Icons.play_circle_outline,
                  size: 18,
                ),
              ),
              Expanded(child: Builder(
                builder: (BuildContext context) {
                  if (showCount) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            "  播放全部",
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: this.onTap,
                        ),
                        Text(
                          "共($songListCount)首",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    );
                  } else {
                    return InkWell(
                      child: Text(
                        "  播放全部",
                        style: TextStyle(fontSize: 13),
                      ),
                      onTap: this.onTap,
                    );
                  }
                },
              )),
              buildCollectWidget()
            ],
          ))),
    );
  }
}

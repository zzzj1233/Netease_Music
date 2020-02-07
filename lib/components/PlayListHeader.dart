import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  final int songListCount;

  final VoidCallback onTap;

  final bool showCount;

  const MusicListHeader(
      {Key key,
      this.songListCount = 0,
      @required this.onTap,
      this.showCount = false})
      : super(key: key);

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
              Icon(
                Icons.menu,
                size: 18,
              ),
              Text("  多选", style: TextStyle(fontSize: 13))
            ],
          ))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(20);
}

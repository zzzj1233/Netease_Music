import 'package:flutter/material.dart';
import 'package:netease_music/util/NumberUtils.dart';

class PlayCount extends StatelessWidget {

  final int count;

  PlayCount({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 5,
        child: Row(
          children: <Widget>[
            Icon(Icons.play_arrow,color: Colors.white,size: 12,),
            Text(NumberUtils.int2chineseNum(count),style: TextStyle(color: Colors.white,fontSize: 9)),
          ],
        )
    );
  }
}

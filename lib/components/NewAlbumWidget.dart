import 'package:flutter/material.dart';
import 'package:netease_music/modal/AlbumInfo.dart';

class NewAlbumWidget extends StatelessWidget {
  final AlbumInfo albumInfo;

  NewAlbumWidget({Key key, this.albumInfo}) : super(key: key);

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
                    albumInfo.smallPicUrl,
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
                            text: this.albumInfo.name,
                            style: TextStyle(fontSize: 12)),
                        TextSpan(
                          text: "  -  ${this.albumInfo.singerName}",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                )))
          ],
        ));
  }
}

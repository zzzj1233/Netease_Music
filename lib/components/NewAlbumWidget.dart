import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/modal/AlbumInfo.dart';

class NewAlbumWidget extends StatelessWidget {
  final AlbumInfo albumInfo;

  NewAlbumWidget({Key key, this.albumInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            style: TextStyle(fontSize: ScreenUtil().setSp(36))),
                        TextSpan(
                          text: "  -  ${this.albumInfo.singerName}",
                          style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(30)),
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

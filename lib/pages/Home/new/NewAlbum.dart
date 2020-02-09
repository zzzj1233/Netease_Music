import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/NewAlbumWidget.dart';
import 'package:netease_music/modal/AlbumInfo.dart';

class NewAlbum extends StatefulWidget {
  NewAlbum({Key key}) : super(key: key);

  @override
  _NewAlbumState createState() {
    return _NewAlbumState();
  }
}

class _NewAlbumState extends State<NewAlbum>
    with AutomaticKeepAliveClientMixin {
  Api api = new Api();

  List<AlbumInfo> _data;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    this._data = await api.selectNewAlbums();
    this.setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._data == null
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : Container(
            height: ScreenUtil().setHeight(420),
            width: MediaQuery.of(context).size.width - 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              itemExtent: MediaQuery.of(context).size.width - 40,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      NewAlbumWidget(
                        albumInfo: this._data[0],
                      ),
                      NewAlbumWidget(
                        albumInfo: this._data[1],
                      ),
                      NewAlbumWidget(
                        albumInfo: this._data[2],
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      NewAlbumWidget(
                        albumInfo: this._data[3],
                      ),
                      NewAlbumWidget(
                        albumInfo: this._data[4],
                      ),
                      NewAlbumWidget(
                        albumInfo: this._data[5],
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                ),
              ],
            ));
  }

  @override
  bool get wantKeepAlive => true;
}

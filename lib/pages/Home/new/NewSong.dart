import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/NewSongWidget.dart';
import 'package:netease_music/modal/NewSongInfo.dart';

class NewSong extends StatefulWidget {
  NewSong({Key key}) : super(key: key);

  @override
  _NewSongState createState() {
    return _NewSongState();
  }
}

class _NewSongState extends State<NewSong> with AutomaticKeepAliveClientMixin {
  Api api = new Api();

  List<NewSongInfo> _data;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    this._data = await api.selectNewSongs(count: 6);
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
              itemExtent: MediaQuery.of(context).size.width - 40,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      NewSongWidget(
                        newSongInfo: this._data[0],
                      ),
                      NewSongWidget(
                        newSongInfo: this._data[1],
                      ),
                      NewSongWidget(
                        newSongInfo: this._data[2],
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      NewSongWidget(
                        newSongInfo: this._data[3],
                      ),
                      NewSongWidget(
                        newSongInfo: this._data[4],
                      ),
                      NewSongWidget(
                        newSongInfo: this._data[5],
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                ),
              ],
            )
          );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/modal/TopListItem.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class DiscoverTopList extends StatefulWidget {
  DiscoverTopList({Key key}) : super(key: key);

  @override
  _DiscoverTopListState createState() {
    return _DiscoverTopListState();
  }
}

class _DiscoverTopListState extends State<DiscoverTopList> {
  Api api = Api();

  List<TopListItem> _topList;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    _topList = await api.selectPartTopList();
    if (mounted) {
      this.setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._topList == null
        ? Container(
            height: 180,
            width: MediaQuery.of(context).size.width - 60,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Container(
            height: 180,
            child: ListView.builder(
              itemCount: this._topList.length,
              scrollDirection: Axis.horizontal,
              itemExtent: MediaQuery.of(context).size.width - 60,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, right: 20),
                  height: 180,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: ColorUtils.hexToColor("#EEEEEE"),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width - 60,
                          margin: EdgeInsets.symmetric(vertical: 1.5),
                          child: Text(
                            "${_topList[index].title} > ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      TopListSongItemBuilder(
                        songList: _topList[index].songList,
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class TopListSongItemBuilder extends StatelessWidget {
  final List<TopListSong> songList;

  const TopListSongItemBuilder({Key key, this.songList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.songList.length >= 3
        ? Column(
            children: <Widget>[
              TopListSongItem(
                song: songList[0],
                index: 1,
              ),
              TopListSongItem(
                song: songList[1],
                index: 2,
              ),
              TopListSongItem(
                song: songList[2],
                index: 3,
              ),
            ],
          )
        : Container();
  }
}

class TopListSongItem extends StatelessWidget {
  TopListSong song;

  int index;

  TopListSongItem({Key key, this.song, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: song.songName,
                              style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: " - ${song.singerName}",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  /// 预留Icon
                  Container(
                    width: 40,
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/components/SliverCustomHeaderDelegate.dart';
import 'package:netease_music/components/StickyHeaderDelegate.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/util/ColorsUtils.dart';

/// 每日推荐组件

class RecommendDaily extends StatefulWidget {
  RecommendDaily({Key key}) : super(key: key);

  @override
  _RecommendDailyState createState() {
    return _RecommendDailyState();
  }
}

class _RecommendDailyState extends State<RecommendDaily> {
  Api api = new Api();

  List<Song> songs;

  bool initialized = false;

  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    this.initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initData() async {
    this.songs = await api.recommendSongs();
    this.setState(() {
      this.initialized = true;
    });
  }

  @override
  void deactivate() {
    if (ModalRoute.of(context).settings.arguments is Function) {
      Function function = ModalRoute.of(context).settings.arguments;
      function();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final songWidget = this.initialized
        ? SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 50,
                  child: _Song(
                    recommendSong: this.songs[index],
                  ),
                );
              },
              childCount: this.songs.length,
            ),
          )
        : SliverToBoxAdapter(
            child: Loading(),
          );
//    AnnotatedRegion<SystemUiOverlayStyle>
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(

            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverCustomHeaderDelegate(
                  title: "每日推荐",
                  collapsedHeight: 30,
                  expandedHeight: 150,
                  paddingTop: MediaQuery.of(context).padding.top,
                  coverImgUrl: "images/onlytheyoung.jpg"),
            ),

            /// todo header被穿透
            SliverPersistentHeader(
              floating: true,
              pinned: false,

              /// StickyHeaderDelegate : maxExtent&minExtent = fixedHeight,build=>child
              delegate: StickyHeaderDelegate(
                  child: Container(
                      height: 50, color: Colors.transparent, child: _Header()),
                  fixedHeight: 50),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              sliver: songWidget,
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Center(
            child: Row(
          children: <Widget>[
            Icon(
              Icons.play_circle_outline,
              size: 18,
            ),
            Expanded(
              child: Text(
                "  播放全部",
                style: TextStyle(fontSize: 13),
              ),
            ),
            Icon(
              Icons.menu,
              size: 18,
            ),
            Text("  多选", style: TextStyle(fontSize: 13))
          ],
        )));
  }
}

class _Song extends StatelessWidget {
  final Song recommendSong;

  _Song({Key key, this.recommendSong}) : super(key: key);

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
                    recommendSong.coverUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 26,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 8),
                      child: Text(this.recommendSong.songName,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      height: 14,
                      width: double.infinity,
                      child: Text(
                        "${this.recommendSong.singerName}   -   ${this.recommendSong.albumName}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
            Container(
              width: 30,
              child: Center(
                  child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.transparent,
                        border:
                            Border.all(color: ColorUtils.lightGrey(), width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ))),
            ),
            Container(
              width: 30,
              child: Icon(
                Icons.format_align_left,
                color: Colors.grey,
                size: 15,
              ),
            )
          ],
        ));
  }
}

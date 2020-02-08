import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/CustomAppBar.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/pages/Home/SongList/components/BlurBackGround.dart';
import 'package:netease_music/pages/Home/SongList/components/RecommendPage.dart';
import 'package:netease_music/util/NumberUtils.dart';

import 'TopSongListTabbar.dart';
import 'components/TopSongListPage.dart';

/// 歌单广场

class SongList extends StatefulWidget {
  SongList({Key key}) : super(key: key);

  @override
  _SongListState createState() {
    return _SongListState();
  }
}

class _SongListState extends State<SongList> with TickerProviderStateMixin {
  String blurImageUrl;

  bool initialized = false;

  Api api = new Api();

  PageController pageController;

  List<Widget> pages = [RecommendPage()];

  List<Map> tags = [
    {"id": 0, "tag": "推荐"}
  ];

  GlobalKey<TopSongListTabbarState> key = new GlobalKey();

  onTagTap(int id, int index, String tagName) {
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
    this.initData();
  }

  @override
  void dispose() {
    if (mounted) {
      pageController.dispose();
    }
    super.dispose();
  }

  void initData() async {
    /// 1. 获取热门标签
    Future tagsFuture = api.hotSongListCategory().then((data) {
      this.tags.addAll(data);
      pages.addAll(this.tags.skip(1).toList().map((item) {
        return TopSongListPage(
          tagName: item["tag"],
        );
      }).toList());
      return data;
    });

    await Future.wait([tagsFuture]);
    this.setState(() {
      this.initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!this.initialized) {
      return Scaffold(body: Loading());
    } else {
      return Scaffold(
          body: Stack(
        children: <Widget>[
          BlurBackGround(),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: <Widget>[
                    /// AppBar
                    CustomAppBar(
                      title: "歌单广场",
                      ignoreStatusBar: true,
                    ),

                    /// Tabbar
                    TopSongListTabbar(
                      labels: this.tags,
                      onTagTap: this.onTagTap,
                      key: this.key,
                    ),

                    /// 歌单页面
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return this.pages[index];
                        },
                        itemCount: this.pages.length,
                        onPageChanged: (index) {
                          key.currentState.setCurrentIndex(index);
                        },
                      ),
                    )
                  ],
                ),
              ))
        ],
      ));
    }
  }
}

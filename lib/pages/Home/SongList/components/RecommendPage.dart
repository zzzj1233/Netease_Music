import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/components/SongListItem.dart';

import 'RecommendPageSwiper.dart';
import 'TopSongListItem.dart';

/// 推荐歌单页面
///

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key}) : super(key: key);

  @override
  _RecommendPageState createState() {
    return _RecommendPageState();
  }
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  Api api = new Api();

  bool initialized = false;

  List<SongListItem> banners = [];
  List<SongListItem> songList = [];

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    /// 2. 获取推荐歌单
    Future dataFuture = api.getRecommendSongList(limit: 15).then((data) {
      this.songList = data.skip(3).toList();
      this.banners = data.sublist(0, 3);
      return data;
    });

    await Future.wait([dataFuture]);
    if (this.mounted) {
      this.setState(() {
        this.initialized = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 轮播图
  /// 歌单
  @override
  Widget build(BuildContext context) {
    final List<Widget> songList = this
        .songList
        .map((item) => TopSongListItem(song: item))
        .toList()
        .cast<Widget>();
    final Widget body = this.initialized
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: CustomScrollView(
              slivers: <Widget>[
                /// 轮播图
                SliverToBoxAdapter(
                  child: RecommendPageSwiper(
                    bannerSongs: this.banners,
                  ),
                ),

                /// 歌单
                SliverGrid.count(
                  crossAxisCount: 3,
                  children: songList,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 9 / 12,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 40,
                  ),
                )
              ],
            ),
          )
        : Loading();
    return body;
  }

  @override
  bool get wantKeepAlive => true;
}

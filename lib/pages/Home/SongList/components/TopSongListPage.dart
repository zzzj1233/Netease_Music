import 'package:flutter/material.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/Loading.dart';
import 'package:netease_music/components/SongListItem.dart';

import 'TopSongListItem.dart';

class TopSongListPage extends StatefulWidget {
  /// 歌单分类ID
  final String tagName;

  TopSongListPage({
    Key key,
    @required this.tagName,
  }) : super(key: key);

  @override
  _TopSongListPageState createState() {
    return _TopSongListPageState();
  }
}

class _TopSongListPageState extends State<TopSongListPage> with AutomaticKeepAliveClientMixin{
  Api api = new Api();

  List<SongListItem> data = [];

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    /// 根据分类名称获取分类下的歌单
    this.data = await api.selectSongListByCategory(widget.tagName);
    if (mounted) {
      this.setState(() {
        this.initialized = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !this.initialized
        ? Loading()
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 9 / 12),
            itemBuilder: (context, index) {
              return TopSongListItem(
                song: this.data[index],
              );
            },
            itemCount: this.data.length,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 30));
  }

  @override
  bool get wantKeepAlive => true;
}

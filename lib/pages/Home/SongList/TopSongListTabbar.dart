import 'package:flutter/material.dart';
import 'package:netease_music/util/ColorsUtils.dart';

typedef SongTapCallback = Function(int id, int index, String tagName);

class TopSongListTabbar extends StatefulWidget {
  TopSongListTabbar({Key key, @required this.labels, @required this.onTagTap})
      : super(key: key);

  final List<Map> labels;

  final SongTapCallback onTagTap;

  @override
  TopSongListTabbarState createState() {
    return TopSongListTabbarState();
  }
}

class TopSongListTabbarState extends State<TopSongListTabbar> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int _index = 0;

  void setCurrentIndex(int index) {
    this.setState(() {
      this._index = index;
      this._scroll(index);
    });
  }

  void _scroll(int index) {
    double offset = index >= 3 ? (index * 60 - 180).toDouble() : 0.0;
    this.scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                controller: this.scrollController,
                scrollDirection: Axis.horizontal,
                itemExtent: 60,
                itemBuilder: (context, index) {
                  String label = widget.labels[index]["tag"];
                  if (label.length > 2) {
                    label = label.substring(0, 2);
                  }

                  /// 每一个tag
                  return InkWell(
                    child: Container(
                      width: 60,
                      height: 30,
                      child: Center(child: Builder(
                        builder: (BuildContext context) {
                          TextStyle style;
                          if (this._index == index) {
                            style = TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600);
                          }
                          return Text(
                            label,
                            style: style,
                            textAlign: TextAlign.start,
                          );
                        },
                      )),
                    ),
                    onTap: () {
                      this.setCurrentIndex(index);
                      widget.onTagTap(widget.labels[index]["id"], index, label);
                    },
                  );
                },
                itemCount: widget.labels.length,
              ),

              /// 底部灰色分割线
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: ColorUtils.lightGrey().withOpacity(.5)))),
            ),
          ),

          /// 右侧编辑图标
          Container(
            width: 30,
            child: Icon(
              Icons.apps,
              color: Colors.white,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}

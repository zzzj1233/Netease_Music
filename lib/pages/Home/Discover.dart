import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netease_music/api/BannerTypes.dart';
import 'package:netease_music/api/index.dart';
import 'package:netease_music/components/DiscoverTopList.dart';
import 'package:netease_music/components/IconTextButton.dart';
import 'package:netease_music/components/NoMore.dart';
import 'package:netease_music/components/RecommendHeader.dart';
import 'package:netease_music/components/RecommendSongWidget.dart';
import 'package:netease_music/components/SongListItem.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/pages/Home/new/NewAlbum.dart';
import 'package:netease_music/pages/Home/new/NewSong.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class Discover extends StatefulWidget {
  Discover({Key key}) : super(key: key);

  @override
  _DiscoverState createState() {
    return _DiscoverState();
  }
}

class _DiscoverState extends State<Discover> with TickerProviderStateMixin {
  Api api = new Api();

  List<dynamic> banners = new List();

  List<SongListItem> recommendSongList = new List();

  List<Song> nineRecommendSongs = new List();

  bool initialized = false;

  PageController pageController;

  bool selectNewSong = true;

  @override
  void initState() {
    super.initState();
    this.pageController = new PageController();
    this.initData();
  }

  @override
  void dispose() {
    this.pageController.dispose();
    super.dispose();
  }

  setStatusBarColor() {
    FlutterStatusbarcolor.setStatusBarColor(ColorUtils.hexToColor("#FAFAFA"));
  }

  void initData() async {
    Future<List> nineSongsFuture = api.recommendNineSongs().then((songs) {
      this.nineRecommendSongs = songs;
      return songs;
    });
    Future<List> bannersFuture =
        api.getBanners(BannerTypes.ANDROID).then((data) {
      this.banners = data;
      return data;
    });

    Future<List> recommendSongListFuture =
        api.getRecommendSongList().then((data) {
      this.recommendSongList = data;
      return data;
    });

    await Future.wait(
        [bannersFuture, recommendSongListFuture, nineSongsFuture]);
    if (mounted) {
      this.setState(() {
        this.initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: !this.initialized
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              children: <Widget>[
                /// 轮播图
                Container(
                    child: AspectRatio(
                        aspectRatio: 21 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Swiper(
                            autoplay: true,
                            itemCount: this.banners.length,
                            pagination: new SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                    size: 5,
                                    activeColor: Colors.red,
                                    activeSize: 5)),
                            itemBuilder: (BuildContext context, index) {
                              return Image.network(
                                this.banners[index]["pic"],
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ))),

                /// 5个圆形图标 + 文字
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconTextButton(
                        icon: FontAwesomeIcons.calendar,
                        title: "每日推荐",
                        onPress: () {
                          Navigator.of(context).pushNamed("recommend_daily",
                              arguments: () {
                            FlutterStatusbarcolor.setStatusBarColor(
                                ColorUtils.hexToColor("#FAFAFA"));
                          });
                        },
                      ),
                      IconTextButton(
                        title: "歌单",
                        icon: FontAwesomeIcons.clipboardList,
                        onPress: () {
                          Navigator.of(context).pushNamed("song_list",
                              arguments: () {
                                FlutterStatusbarcolor.setStatusBarColor(
                                    ColorUtils.hexToColor("#FAFAFA"));
                              });
                        },
                      ),
                      IconTextButton(
                        title: "排行榜",
                        icon: Icons.equalizer,
                      ),
                      IconTextButton(
                        title: "电台",
                        icon: Icons.radio,
                      ),
                      IconTextButton(
                        title: "直播",
                        icon: Icons.live_tv,
                      )
                    ],
                  ),
                ),

                /// 推荐歌单title
                RecommendHeader(
                  smallTitle: "推荐歌单",
                  mainTitle: "为你精挑细选",
                  buttonTitle: "查看更多",
                ),

                /// 推荐歌单ListView
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 150,
                  child: ListView.builder(
                    itemExtent: 110,
                    itemBuilder: (context, index) {
                      return SongListItem(
                        picUrl: this.recommendSongList[index].picUrl,
                        title: this.recommendSongList[index].title,
                        playCount: this.recommendSongList[index].playCount,
                      );
                    },
                    itemCount: this.recommendSongList.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                /// 推荐歌曲的title
                RecommendHeader(
                  smallTitle: "每日推荐",
                  mainTitle: "一曲一唱思年华",
                  buttonTitle: "播放全部",
                ),

                /// 推荐歌曲ListView
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 140,
                  child: ListView(
                    itemExtent: MediaQuery.of(context).size.width - 40,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Column(
                            children: <Widget>[
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[0],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[1],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[2],
                              ),
                            ],
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Column(
                            children: <Widget>[
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[3],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[4],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[5],
                              ),
                            ],
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Column(
                            children: <Widget>[
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[6],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[7],
                              ),
                              RecommendSongWidget(
                                recommendSong: this.nineRecommendSongs[8],
                              ),
                            ],
                          )),
                    ],
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                /// 新歌新碟title
                RecommendHeader(
                    buttonTitle: selectNewSong ? "查看新歌" : "查看新碟",
                    smallTitle:
                        formatDate(DateTime.now(), ["m", "月", "d", "日"]),
                    mainWidget: Container(
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: 30,
                              child: Text(
                                "新歌",
                                style: selectNewSong
                                    ? TextStyle(fontWeight: FontWeight.w700)
                                    : TextStyle(color: Colors.grey),
                              ),
                            ),
                            onTap: () {
                              if (this.selectNewSong) {
                                return;
                              }
                              this.setState(() {
                                this.selectNewSong = true;
                                this.pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            },
                          ),
                          VerticalDivider(color: Colors.grey),
                          InkWell(
                            child: Container(
                              width: 30,
                              child: Text(
                                "新碟",
                                style: selectNewSong
                                    ? TextStyle(color: Colors.grey)
                                    : TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            onTap: () {
                              if (!this.selectNewSong) {
                                return;
                              }
                              this.setState(() {
                                this.selectNewSong = false;
                                this.pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            },
                          ),
                        ],
                      ),
                    )),

                /// 新歌新碟PageView
                Container(
                    width: double.infinity,
                    height: 140,
                    margin: EdgeInsets.only(top: 10),
                    child: PageView.builder(
                      controller: this.pageController,
                      itemBuilder: (context, index) {
                        return index == 0 ? new NewSong() : new NewAlbum();
                      },
                      itemCount: 2,
                    )),

                /// 排行榜title
                RecommendHeader(
                  smallTitle: "排行榜",
                  mainTitle: "热歌风向榜",
                  buttonTitle: "查看更多",
                ),

                /// 排行榜ListView
                DiscoverTopList(),
                NoMore()
              ],
            ),
    ));
  }
}

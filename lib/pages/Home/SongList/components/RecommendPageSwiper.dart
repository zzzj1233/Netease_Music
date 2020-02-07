import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netease_music/components/CommonImage.dart';
import 'package:netease_music/components/PlayCount.dart';
import 'package:netease_music/components/SongListItem.dart';
import 'package:netease_music/provider/BlurImageModal.dart';
import 'package:provider/provider.dart';

class RecommendPageSwiper extends StatefulWidget {
  final List<SongListItem> bannerSongs;

  RecommendPageSwiper({Key key, this.bannerSongs}) : super(key: key);

  @override
  _RecommendPageSwiperState createState() {
    return _RecommendPageSwiperState();
  }
}

class _RecommendPageSwiperState extends State<RecommendPageSwiper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 10),
      height: 180,
      child: Container(
        height: 180,
        child: Swiper(

          itemBuilder: (BuildContext context, int index) {
            final double opacity = _index == index ? 1 : .3;
            return _SwiperItem(
              opacity: opacity,
              url: this.widget.bannerSongs[index].picUrl,
              title: this.widget.bannerSongs[index].title,
              playCount: this.widget.bannerSongs[index].playCount,
            );
          },
          itemCount: 3,
          viewportFraction: 0.5,
          scale: 0.9,
          onIndexChanged: (index) {
            this.setState(() {
              this._index = index;
              Provider.of<BlurImageModal>(context, listen: false)
                  .setUrl(this.widget.bannerSongs[index].picUrl);
            });
          },
        ),
      ),
    );
  }
}

class _SwiperItem extends StatelessWidget {
  final double opacity;
  final String url;
  final String title;
  final int playCount;

  const _SwiperItem({Key key, this.opacity, this.url, this.title, this.playCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: opacity,
        child: Column(
          children: <Widget>[
            LayoutBuilder(builder: (context,constraint){
              return Container(
                height: 140,
                width: constraint.maxWidth,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: constraint.maxWidth,
                      child: CommonImage(
                        url: url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    PlayCount(count: this.playCount,),

                  ],
                ),
              );
            },),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white.withOpacity(.8),
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 13
                  ),
                  maxLines: 2,
                ),
              ),
            )
          ],
        ));
  }
}

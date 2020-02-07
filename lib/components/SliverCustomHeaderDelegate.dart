import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  }){
  }

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

//  void updateStatusBarBrightness(shrinkOffset) {
//    if (shrinkOffset > 50 && this.statusBarMode == 'dark') {
//      this.statusBarMode = 'light';
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarBrightness: Brightness.light,
//        statusBarIconBrightness: Brightness.light,
//      ));
//    } else if (shrinkOffset <= 50 && this.statusBarMode == 'light') {
//      this.statusBarMode = 'dark';
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarBrightness: Brightness.dark,
//        statusBarIconBrightness: Brightness.dark,
//      ));
//    }
//  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 8, 6, 7);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: Image.asset(this.coverImgUrl, fit: BoxFit.cover)),
          Positioned(
            left: 0,
            top: this.maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: this
                                .makeStickyHeaderTextColor(shrinkOffset, true),
                            size: 16,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: this
                                .makeStickyHeaderTextColor(shrinkOffset, false),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

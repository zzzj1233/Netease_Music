import 'package:flutter/cupertino.dart';

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Container child;
  final double fixedHeight;

  StickyHeaderDelegate({@required this.child, @required this.fixedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => fixedHeight;

  @override
  double get minExtent => fixedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

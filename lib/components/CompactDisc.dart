import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_music/util/ImageUtils.dart';

class CompactDisc extends StatefulWidget {
  final AnimationController animationController;

  final String imageUrl;

  CompactDisc(
      {Key key, @required this.animationController, @required this.imageUrl})
      : super(key: key);

  @override
  _CompactDiscState createState() {
    return _CompactDiscState();
  }
}

class _CompactDiscState extends State<CompactDisc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: widget.animationController,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 20,
              )
            ],
            color: Colors.blue,
            image: DecorationImage(
                image: widget.imageUrl != null
                    ? NetworkImage(
                        widget.imageUrl,
                      )
                    : AssetImage(ImageUtils.defaultBlurImageUrl))),
      ),
    );
  }
}

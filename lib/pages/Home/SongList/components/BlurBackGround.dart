import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:netease_music/provider/BlurImageModal.dart';
import 'package:provider/provider.dart';

class BlurBackGround extends StatefulWidget {
  BlurBackGround({Key key}) : super(key: key);

  @override
  _BlurBackGroundState createState() {
    return _BlurBackGroundState();
  }
}

class _BlurBackGroundState extends State<BlurBackGround> {
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
    String url = Provider.of<BlurImageModal>(context).url;
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: url != null
                ? NetworkImage(url)
                : AssetImage("images/defaultBlurImage.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.4), BlendMode.dstOut)),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 30.0),
        child: new Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(.45)),
        ),
      ),
    );
  }
}

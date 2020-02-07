import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget{
  final Widget child;
  final double height;
  const BlurContainer({Key key, this.child, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: this.height,
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image:
            NetworkImage("https://www.itying.com/images/flutter/1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.4), BlendMode.dstOut)),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double width;
  final double height;

  CommonImage({Key key, @required this.url, this.fit, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: this.fit,
      height: this.height,
      width: this.width,
      placeholder: (context, url) => CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

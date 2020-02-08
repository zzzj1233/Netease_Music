import 'package:flutter/material.dart';

class ImageUtils {
  static Image baseImg() {
    return Image.network("https://www.itying.com/images/flutter/1.png");
  }

  static String url() {
    return "https://www.itying.com/images/flutter/1.png";
  }

  static Image defaultBlurImage(BoxFit fit, double width, double height) {
    return Image.asset("images/defaultBlurImage.jpg",
        fit: fit, width: width, height: height);
  }

  static String defaultBlurImageUrl = "images/defaultBlurImage.jpg";

  static String smallImageSuffix = "?param=200y200";

  static String getSmallImageSuffix(wh) {
    return "?param=${wh}y$wh";
  }
}

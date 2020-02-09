import 'package:flutter/cupertino.dart';

class IconFontUtils {
  static IconData getIcon(String hexadecimal) {

    return IconData(int.parse(("0" + hexadecimal)), fontFamily: "iconfont");
  }

  static IconData getIcon2(String hexadecimal) {

    return IconData(int.parse(("0" + hexadecimal)), fontFamily: "iconfont2");
  }
}

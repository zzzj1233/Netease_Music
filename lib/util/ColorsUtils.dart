import 'dart:ui';

class ColorUtils {
  static Color hexToColor(String s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null ||
        s.length != 7 ||
        int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }

    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color baseColor() {
    return ColorUtils.hexToColor("#C62F2F");
  }

  static Color lightGrey() {
    return ColorUtils.hexToColor("#DCDCDC");
  }

  static Color baseWhiteColor() {
    return ColorUtils.hexToColor("#FAFAFA");
  }
}

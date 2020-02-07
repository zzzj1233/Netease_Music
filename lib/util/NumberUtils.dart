class NumberUtils {
  static String int2chineseNum(int num) {
    if (num < 10000) {
      return num.toString();
    } else if (num < 100000000) {
      return "${(num / 10000).truncate()}万";
    }
    return "${(num / 100000000).toStringAsFixed(2)}亿";
  }
}

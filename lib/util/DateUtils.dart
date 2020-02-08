class DateUtils {

  static String formatSecond(int second) {
    /// 小于一分钟
    if (second < 60) {
      if (second < 10) {
        return "00:0$second";
      }
      return "00:$second";
    } else {
      int minute = second ~/ 60;
      int sec = second % 60;
      String minuteStr = minute < 10 ? "0$minute:" : "$minute:";
      String secStr = sec < 10 ? "0$sec" : sec.toString();
      return minuteStr + secStr;
    }
  }

}

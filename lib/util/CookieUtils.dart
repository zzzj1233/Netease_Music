class CookieUtils {
  static String setCookieListToCookieString(List setCookie) {
    if (setCookie == null || setCookie.isEmpty) {
      return null;
    }

    StringBuffer stringBuffer = new StringBuffer();

    for (int i = 0; i < setCookie.length; i++) {
      stringBuffer.write(setCookie[i]);
      if (i != setCookie.length - 1) {
        stringBuffer.write("; ");
      }
    }
    return stringBuffer.toString();
  }
}

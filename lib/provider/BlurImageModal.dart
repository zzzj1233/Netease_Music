import 'package:flutter/cupertino.dart';

class BlurImageModal with ChangeNotifier {
  String _url;

  String get url => _url;

  BlurImageModal();

  void setUrl(String url) {
    this._url = url;
    notifyListeners();
  }
}

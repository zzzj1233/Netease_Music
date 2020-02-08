import 'package:netease_music/util/ImageUtils.dart';

class AlbumInfo {
  String name;
  String singerName;
  String picurl;
  String smallPicUrl;

  AlbumInfo.formApi(Map map) {
    this.name = map["name"];
    this.singerName = map["artist"]["name"];
    this.picurl = map["picUrl"];
    this.smallPicUrl = this.picurl + ImageUtils.smallImageSuffix;
  }
}

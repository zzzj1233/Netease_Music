class AlbumInfo {
  String name;
  String singerName;
  String picurl;

  AlbumInfo.formApi(Map map) {
    this.name = map["name"];
    this.singerName = map["artist"]["name"];
    this.picurl = map["picUrl"];
  }

  @override
  String toString() {
    return 'AlbumInfo{name: $name, singerName: $singerName, picurl: $picurl}';
  }
}

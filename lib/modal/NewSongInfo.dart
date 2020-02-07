class NewSongInfo {
   String songName;
   String singerName;
   String picurl;
   String alias;

  NewSongInfo({this.songName, this.singerName, this.picurl, this.alias});

   NewSongInfo.formApi(Map map){
     this.songName = map["song"]["name"];
     if (map["song"]["alias"] is List) {
       List alias = map["song"]["alias"];
       if (alias.isNotEmpty) {
         this.alias = map["song"]["alias"][0];
       }
     }
     this.picurl = map["song"]["album"]["picUrl"];
     this.singerName = _getSingerName(map["song"]);
   }

   String _getSingerName(Map song) {
     if (song["artists"] is List) {
       StringBuffer stringBuffer = new StringBuffer();
       List list = song["artists"];
       for (int i = 0; i < list.length; i++) {
         stringBuffer.write(list[i]["name"]);
         if (i != list.length - 1) {
           stringBuffer.write(" / ");
         }
       }
       return stringBuffer.toString();
     } else {
       return song["artists"]["name"];
     }
   }

   @override
  String toString() {
    return 'NewSongInfo{songName: $songName, singerName: $singerName, picurl: $picurl, alias: $alias}';
  }
}

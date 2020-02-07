class TopListItem {
  String title;
  String id;
  List<TopListSong> songList;

  TopListItem({this.title, this.id, this.songList});
}

class TopListSong {
  String songName;
  String singerName;
  String picurl;

  TopListSong({this.songName, this.singerName,this.picurl});
}

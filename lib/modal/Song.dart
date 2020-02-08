import 'package:netease_music/util/ImageUtils.dart';

class Song {
  String singerName;
  String songName;
  String coverUrl;
  String albumName;
  int duration;
  int id;
  String smallCoverUrl;

  Song(
      {this.singerName, this.songName, this.coverUrl, this.albumName, this.duration, int id});

  Song.fromApi(Map song) {
    this.songName = song["name"];
    this.singerName = _getSingerName(song);
    this.coverUrl = song["album"]["picUrl"];
    this.albumName = song["album"]["name"];
    this.duration = song["duration"];
    this.id = song["id"];
    this.smallCoverUrl = this.coverUrl + ImageUtils.smallImageSuffix;
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
    return 'RecommendSong{singerName: $singerName, songName: $songName, coverUrl: $coverUrl}';
  }
}

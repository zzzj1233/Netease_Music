import 'package:netease_music/modal/SongList.dart';
import 'package:netease_music/util/ImageUtils.dart';

class Song {
  String singerName;
  String songName;
  String coverUrl;
  String albumName;
  int duration;
  int id;
  String smallCoverUrl;

  /// SongListSong

  /// 是否是独家
  bool private;

  /// 是否有hq音质
  bool hq;

  /// 是否可以播放
  bool playable;

  Song.fromSongListSong(SongListSong song) {
    this.singerName = song.singerName;
    this.playable = song.playable;
    this.hq = song.hq;
    this.private = song.private;
    this.coverUrl = song.picUrl;
    this.albumName = song.albumName;
    this.id = song.id;
    this.songName = song.name;
    if (this.coverUrl != null) {
      this.smallCoverUrl = this.coverUrl + ImageUtils.smallImageSuffix;
    }
  }

  Song(
      {this.singerName,
      this.songName,
      this.coverUrl,
      this.albumName,
      this.duration,
      int id});

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
      List list = song["artists"];
      if (list.length == 1) {
        return list[0]["name"];
      }

      StringBuffer stringBuffer = new StringBuffer();

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

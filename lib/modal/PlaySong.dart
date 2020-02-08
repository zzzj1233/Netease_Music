import 'package:netease_music/util/ImageUtils.dart';

class PlaySong {
  final String url;
  final String coverUrl;
  final String songName;
  final String singerName;
  int duration;
  final bool isFavorite;
  String smallCoverUrl;

  PlaySong(this.coverUrl, this.songName, this.singerName, this.duration,
      this.isFavorite, this.url) {
    this.smallCoverUrl = this.coverUrl == null
        ? null
        : this.coverUrl;
    this.duration = this.duration == null ? null : this.duration ~/ 1000;
  }

  @override
  String toString() {
    return 'PlaySong{url: $url, coverUrl: $coverUrl, songName: $songName, singerName: $singerName, duration: $duration, isFavorite: $isFavorite, smallCoverUrl: $smallCoverUrl}';
  }
}

import 'package:netease_music/util/ImageUtils.dart';

/// 歌单

class SongList {
  /// 仅显示5个订阅者头像
  List<String> subscribers;

  bool subscribed;

  SongListCreator creator;

  String description;

  List<SongListSong> songs;

  int length;

  int shareCount;

  int commentCount;

  String coverImgUrl;

  int subscribedCount;

  int playCount;

  String name;

  @override
  String toString() {
    return 'SongList{subscribers: $subscribers, subscribed: $subscribed, creator: $creator, description: $description, songs: $songs, length: $length}';
  }

  SongList.fromMap(Map map) {
    this._fillSubscribed(map["playlist"]["subscribers"]);
    this.subscribed = map["playlist"]["subscribed"];
    this._fillCreator(map["playlist"]["creator"]);
    this.description = map["playlist"]["description"];
    this._fillSong(map["playlist"]["tracks"], map["privileges"]);
    this.length = this.songs.length;
    this.shareCount = map["playlist"]["shareCount"];
    this.commentCount = map["playlist"]["commentCount"];
    this.coverImgUrl = map["playlist"]["coverImgUrl"];
    this.subscribedCount = map["playlist"]["subscribedCount"];
    this.name = map["playlist"]["name"];
    this.playCount = map["playlist"]["playCount"];
  }

  void _fillSubscribed(List list) {
    if (list.isEmpty) {
      return;
    }

    this.subscribers = list
        .map((item) => item["avatarUrl"] + ImageUtils.getSmallImageSuffix(50))
        .toList()
        .cast<String>();
  }

  void _fillCreator(Map map) {
    if (map == null || map.isEmpty) {
      return;
    }
    this.creator = new SongListCreator(map["userId"], map["nickname"],
        map["avatarUrl"] + ImageUtils.getSmallImageSuffix(50));
  }

  void _fillSong(List songs, List privileges) {
    if (songs.isEmpty) {
      return;
    }
    this.songs = [];

    for (int i = 0; i < songs.length; i++) {
      this.songs.add(SongListSong(
            name: songs[i]["name"],
            id: songs[i]["id"],
            albumName: songs[i]["al"]["name"],
            picUrl: songs[i]["al"]["picUrl"],
            private: songs[i]["copyright"] == 2,
            hq: songs[i]["h"] != null,
            playable: privileges[i]["st"] == 0,
            singerName: _getSingerName(songs[i]["ar"]),
          ));
    }
  }

  String _getSingerName(ar) {
    if (ar is List) {
      if (ar.length == 1) {
        return ar[0]["name"];
      }

      StringBuffer stringBuffer = new StringBuffer();
      List list = ar;

      for (int i = 0; i < list.length; i++) {
        stringBuffer.write(list[i]["name"]);
        if (i != list.length - 1) {
          stringBuffer.write(" / ");
        }
      }

      return stringBuffer.toString();
    } else {
      return "未知";
    }
  }
}

class SongListCreator {
  int id;
  String nickname;
  String avatarUrl;

  @override
  String toString() {
    return 'SongListCreator{id: $id, nickname: $nickname, avatarUrl: $avatarUrl}';
  }

  SongListCreator(this.id, this.nickname, this.avatarUrl);
}

class SongListSong {
  /// 是否是独家
  bool private;

  /// 是否有hq音质
  bool hq;

  String name;

  String singerName;

  String albumName;

  int id;

  String picUrl;

  bool playable;

  @override
  String toString() {
    return 'SongListSong{private: $private, hq: $hq, name: $name, singerName: $singerName, albumName: $albumName, id: $id, picUrl: $picUrl, playable: $playable}';
  }

  SongListSong(
      {this.private,
      this.hq,
      this.name,
      this.singerName,
      this.albumName,
      this.id,
      this.picUrl,
      this.playable});
}

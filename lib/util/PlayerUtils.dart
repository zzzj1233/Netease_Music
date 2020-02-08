import 'package:netease_music/api/index.dart';
import 'package:netease_music/modal/NewSongInfo.dart';
import 'package:netease_music/modal/PlaySong.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/provider/PlayerModal.dart';

class PlayerUtils {
  static void playSong(PlaySong playSong, PlayerModal playerModal) {
    playerModal.play(playSong);
  }

  static void playSongFromSong(Song song, PlayerModal playerModal) async {
    /// 获取URL
    String url = await Api().getSongUrlById(song.id);
    PlaySong ps = new PlaySong(song.coverUrl, song.songName, song.singerName,
        song.duration, false, url);
    playSong(ps, playerModal);
  }

  static void playSongFromNewSong(NewSongInfo newSongInfo, PlayerModal playerModal) async {
    /// 获取URL
    String url = await Api().getSongUrlById(newSongInfo.id);
    PlaySong ps = new PlaySong(newSongInfo.picurl, newSongInfo.songName, newSongInfo.singerName,
        newSongInfo.duration, false, url);
    playSong(ps, playerModal);
  }
}

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:netease_music/modal/PlaySong.dart';
import 'package:netease_music/support/PlayMode.dart';

class PlayerModal extends ChangeNotifier {
  AudioPlayer audioPlayer;

  int _currentPlayTime;

  PlaySong _currentSong;

  StreamController<int> _streamController;

  List<PlaySong> _playSongList = [];

  /// todo 从storage中读取
  PlayMode _playMode = PlayMode.LIST_CYCLIC;

  /// 播放列表
  List<PlaySong> get playSongList => _playSongList;

  /// 播放模式
  PlayMode get playMode => _playMode;

  /// 当前播放时间
  int get currentPlayTime => _currentPlayTime;

  /// 当前播放的歌曲
  PlaySong get currentSong => _currentSong;

  /// 播放时间的Stream
  Stream<int> get durationStream => _streamController.stream;

  void init() async {
    this.audioPlayer = new AudioPlayer();
    this._streamController = StreamController.broadcast();
    await this.audioPlayer.setReleaseMode(ReleaseMode.STOP);

    /// 监听播放时间的变化
    this.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      this._currentPlayTime = p.inSeconds;
      _streamController.sink.add(this._currentPlayTime);
    });
  }

  /// 播放单首音乐
  void play(PlaySong song) {
    this._currentSong = song;
    this.audioPlayer.play(song.url);
    notifyListeners();
  }

  void pause() {
    if (this.audioPlayer.state == AudioPlayerState.PLAYING) {
      this.audioPlayer.pause();
    }
  }

  void resume() {
    if (this.audioPlayer.state == AudioPlayerState.PAUSED) {
      this.audioPlayer.resume();
    }
  }

  @override
  void dispose() {
    _streamController.sink.close();
    _streamController.close();
    this.audioPlayer.release();
    this.audioPlayer.dispose();
    super.dispose();
  }
}

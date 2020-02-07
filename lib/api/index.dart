import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:netease_music/components/SongListItem.dart';
import 'package:netease_music/modal/AlbumInfo.dart';
import 'package:netease_music/modal/CheckPhoneExistsModal.dart';
import 'package:netease_music/modal/NewSongInfo.dart';
import 'package:netease_music/modal/Song.dart';
import 'package:netease_music/modal/TopListItem.dart';
import 'package:netease_music/util/CookieUtils.dart';

import 'BannerTypes.dart';

class Api {
  final Dio dio = Dio();

  String cookie;

  Random random = new Random();

  static final Api _instance = Api._internal();

  static Api getInstance() {
    return _instance;
  }

  factory Api() {
    return _instance;
  }

  Api._internal() {
    dio.options.baseUrl = "http://192.168.0.4:3000";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (cookie != null && cookie.isNotEmpty) {
        options.headers.putIfAbsent("cookie", () => cookie);
      }
      return options; //continue
    }, onResponse: (Response response) async {
      if (response.data["code"] != 200) {
        BotToast.showText(text: "${response.data["msg"]}");
      }

      /// set cookie
      if (response.headers.map["set-cookie"] != null &&
          response.headers.map["set-cookie"].isNotEmpty) {
        this.cookie = CookieUtils.setCookieListToCookieString(
            response.headers.map["set-cookie"]);
      }

      return response.data; // continue
    }, onError: (DioError e) async {
      print(e);
      // 当请求失败时做一些预处理
      BotToast.showText(text: "请求失败");
      return e; //continue
    }));
  }

  /// 发送手机登录验证码
  Future<Response> sendPhoneLoginCode(String phone) async {
    Response response = await dio.get("/captcha/sent?phone=$phone");
    return response;
  }

  /// 验证手机登录验证码
  Future<Response> verifyPhoneLoginCode(String phone, String code) async {
    Response response =
        await dio.get("/captcha/verify?phone=$phone&captcha=$code");
    return response;
  }

  /// 获取轮播图
  Future<List<dynamic>> getBanners(BannerTypes bannerTypes) async {
    int type = 1;
    switch (bannerTypes) {
      case BannerTypes.PC:
        type = 0;
        break;
      case BannerTypes.ANDROID:
        type = 1;
        break;
      case BannerTypes.IPHONE:
        type = 2;
        break;
      case BannerTypes.IPAD:
        type = 3;
        break;
    }

    final url = "/banner?type=$type";
    Response response = await dio.get(url);
    return response.data["banners"];
  }

  /// 获取推荐歌单
  Future<List<SongListItem>> getRecommendSongList({int limit: 10}) async {
    final url = "/personalized?limit=$limit";
    Response response = await dio.get(url);

    List list = response.data["result"];
    List<SongListItem> result = [];

    list.forEach((item) {
      SongListItem songListItem = new SongListItem();
      songListItem.title = item["name"];
      songListItem.picUrl = item["picUrl"];
      songListItem.playCount = item["playCount"];
      songListItem.id = item["id"];
      result.add(songListItem);
    });

    return result;
  }

  /// 随机推荐歌单
  Future<List> randomRecommendSongList() async {
    return null;
  }

  /// 每日推荐歌单
  Future<List> getRecommendDaily() async {
    const String url = "/recommend/songs";
    Response response = await dio.get(url);
    return response.data["recommend"];
  }

  /// 获取每日推荐歌曲
  Future<List<Song>> recommendSongs() async {
    List songs = await getRecommendDaily();
    List<Song> recommendSongList = [];



    songs.forEach((song){
      recommendSongList.add(Song.fromApi(song));
    });

    return recommendSongList;
  }

  /// 从每日推荐中随机推荐9首歌
  Future<List<Song>> recommendNineSongs() async {
    List songs = await getRecommendDaily();
    List<int> added = [];
    List<Song> recommendSongList = [];

    int index = -1;

    while (recommendSongList.length < 9) {
      do {
        index = random.nextInt(songs.length);
      } while (added.contains(index));
      added.add(index);
      Map song = songs[index];

      recommendSongList.add(Song.fromApi(song));
    }

    return recommendSongList;
  }

  Future<Response> phoneLogin(String phone, String passWord) async {
    final String url = "/login/cellphone?phone=$phone&password=$passWord";
    return await dio.get(url);
  }

  Future<bool> login(String userJson) async {
    Map<String, dynamic> userInfoMap = json.decode(userJson);
    String account = userInfoMap["account"];
    String passWord = userInfoMap["passWord"];

    Response response = await phoneLogin(account, passWord);

    /// 登录失败
    if (response.data["code"] != 200) {
      return false;
    } else {
      /// 登录成功
      return true;
    }
  }

  /// 检查手机号是否注册过
  Future<CheckPhoneExistsModal> checkPhoneRegistered(String phone) async {
    final url = "/cellphone/existence/check?phone=$phone";
    Response response = await dio.get(url);
    CheckPhoneExistsModal checkPhoneExistsModal =
        CheckPhoneExistsModal.fromMap(response.data);
    return checkPhoneExistsModal;
  }

  /// 新歌速递
  Future<List<NewSongInfo>> selectNewSongs({int count: 3}) async {
    if (count > 10) {
      count = 10;
    }
    const String url = "/personalized/newsong";
    Response response = await dio.get(url);

    List list = response.data["result"];
    List<NewSongInfo> result = new List();
    List<int> added = new List();

    int index = -1;

    for (int i = 0; i < count; i++) {
      do {
        index = random.nextInt(count);
      } while (added.contains(index));
      added.add(index);
      result.add(NewSongInfo.formApi(list[i]));
    }
    return result;
  }

  /// 获取新碟
  Future<List<AlbumInfo>> selectNewAlbums({int count: 6}) async {
    final String url = "/top/album?offset=0&limit=$count";
    Response response = await dio.get(url);

    List list = response.data["albums"];
    List<AlbumInfo> result = [];

    list.forEach((item) {
      result.add(AlbumInfo.formApi(item));
    });

    return result;
  }

  /// 榜单摘要
  Future<List<TopListItem>> selectPartTopList({int count = 5}) async {
    String url = "/toplist/detail";
    Response response = await dio.get(url);
    List list = response.data["list"];
    Iterable subList = list.sublist(0, count);

    List<TopListItem> result = [];
    subList.forEach((item) {
      List<TopListSong> songList = [];
      if (item["tracks"] is List) {
        List tracks = item["tracks"];
        tracks.forEach((track) {
          TopListSong song = new TopListSong(
              songName: track["first"], singerName: track["second"]);
          songList.add(song);
        });
      }

      result.add(TopListItem(
          title: item["name"], id: item["id"].toString(), songList: songList));
    });
    return result;
  }

  /// 热门歌单分类
  Future<List<Map>> hotSongListCategory() async {
    const url = "/playlist/hot";
    Response response = await dio.get(url);
    List list = response.data["tags"];

    List<Map> result = [];

    list.forEach((item) {
      result.add({"id": item["id"], "tag": item["name"]});
    });
    return result;
  }

  /// 根据歌单分类名称获取相应歌单列表
  Future<List<SongListItem>> selectSongListByCategory(String categoryName,
      {limit = 15}) async {
    final url = "/top/playlist?limit=$limit&cat=$categoryName";
    Response response = await dio.get(url);

    List<SongListItem> result = [];
    List list = response.data["playlists"];

    list.forEach((item) {
      SongListItem songListItem = new SongListItem();
      songListItem.title = item["name"];
      songListItem.picUrl = item["coverImgUrl"];
      songListItem.id = item["id"];
      songListItem.updateTime = item["updateTime"];
      songListItem.playCount = item["playCount"];
      result.add(songListItem);
    });
    return result;
  }
}

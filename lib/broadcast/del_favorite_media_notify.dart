import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.11将歌曲从指定的自建歌单中取消收藏通知
class DelFavoriteMediaNotify extends BaseProtocol {
  String playListId;
  DelFavoriteMediaNotify(Map json) : super(json) {
    playListId = arg["playListId"].toString();
  }
}

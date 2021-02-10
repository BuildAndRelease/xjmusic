import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.9歌曲收藏到指定的自建歌单通知
class AddFavoriteMediaNotify extends BaseProtocol {
  String playListId;
  AddFavoriteMediaNotify(Map json) : super(json) {
    playListId = arg["playListId"].toString();
  }
}

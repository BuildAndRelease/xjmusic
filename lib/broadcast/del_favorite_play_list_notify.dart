import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.5删除自建歌单通知
class DelFavoritePlayListNotify extends BaseProtocol {
  String playListId;
  DelFavoritePlayListNotify(Map json) : super(json) {
    playListId = arg["playListId"].toString();
  }
}

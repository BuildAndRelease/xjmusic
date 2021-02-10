import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.7修改自建歌单名通知
class RenameFavoritePlayListNotify extends BaseProtocol {
  String playListId;
  String playListName;
  RenameFavoritePlayListNotify(Map json) : super(json) {
    playListId = arg["playListId"].toString();
    playListName = arg["playListName"].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.3新建自建歌单通知
class AddFavoritePlayListNotify extends BaseProtocol {
  String playListId;
  String playListName;
  String editStat;
  AddFavoritePlayListNotify(Map json) : super(json) {
    playListId = arg["playListId"].toString();
    playListName = arg["playListName"].toString();
    editStat = arg["editStat"].toString();
  }
}

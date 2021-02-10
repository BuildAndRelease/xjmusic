import 'package:xj_music/broadcast/base_protocol.dart';

//4.20.3新建收藏歌单通知
class DelAlbumSetFavoriteListNotify extends BaseProtocol {
  String folderId;
  DelAlbumSetFavoriteListNotify(Map json) : super(json) {
    folderId = arg["folderId"].toString();
  }
}

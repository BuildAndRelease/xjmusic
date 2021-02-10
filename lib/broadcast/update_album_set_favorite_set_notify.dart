import 'package:xj_music/broadcast/base_protocol.dart';

//4.20.10将歌单收藏到指定的收藏歌单通知
class UpdateAlbumSetFavoriteSetNotify extends BaseProtocol {
  String folderId;
  UpdateAlbumSetFavoriteSetNotify(Map json) : super(json) {
    folderId = arg["folderId"].toString();
  }
}

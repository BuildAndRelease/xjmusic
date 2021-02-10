import 'package:xj_music/broadcast/base_protocol.dart';

//4.20.3新建收藏歌单通知
class AddAlbumSetFavoriteListNotify extends BaseProtocol {
  String folderId;
  String folderName;
  AddAlbumSetFavoriteListNotify(Map json) : super(json) {
    folderId = arg["folderId"].toString();
    folderName = arg["folderName"].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.20.7修改收藏歌单的名称通知
class RenameAlbumSetFavoriteListNotify extends BaseProtocol {
  String folderId;
  String folderName;
  RenameAlbumSetFavoriteListNotify(Map json) : super(json) {
    folderId = arg["folderId"].toString();
    folderName = arg["folderName"].toString();
  }
}

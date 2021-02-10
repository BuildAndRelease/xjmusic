import 'package:xj_music/broadcast/base_protocol.dart';

//歌单ID
class FolderIdResponseModel extends BaseProtocol {
  String resultCode;
  String folderId;

  FolderIdResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    folderId = arg['folderId'].toString();
  }
}

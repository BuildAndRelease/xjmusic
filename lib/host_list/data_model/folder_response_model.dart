import 'package:xj_music/broadcast/base_protocol.dart';

//歌单
class FolderResponseModel extends BaseProtocol {
  String resultCode;
  String folderId;
  String folderName;

  FolderResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    folderId = arg['folderId'].toString();
    folderName = arg['folderName'].toString();
  }
}

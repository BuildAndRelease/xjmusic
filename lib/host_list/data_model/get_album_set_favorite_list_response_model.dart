import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.2新建自建歌单
class GetAlbumSetFavoriteListResponseModel extends BaseProtocol {
  String resultCode;
  List albumSetFolderList;

  GetAlbumSetFavoriteListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    albumSetFolderList = arg['albumSetFolderList'];
  }

  get albumSetFolderListCount => albumSetFolderList?.length ?? 0;

  Folder albumSetFolderListAtIndex(int index) {
    return Folder.fromJson(albumSetFolderList[index]);
  }
}

class Folder {
  String folderId;
  String folderName;

  Folder({this.folderId, this.folderName});

  Folder.fromJson(Map json) {
    folderId = json['folderId'].toString();
    folderName = json['folderName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['folderId'] = this.folderId;
    data['folderName'] = this.folderName;
    return data;
  }
}

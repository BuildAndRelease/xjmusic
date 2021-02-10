import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.6修改自建歌单名
class RenameFavoritePlayListResponseModel extends BaseProtocol {
  String resultCode;
  String playListId;
  String playListName;

  RenameFavoritePlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playListId = arg['playListId'].toString();
    playListName = arg['playListName'].toString();
  }
}

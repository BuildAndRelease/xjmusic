import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.2新建自建歌单
class AddFavoritePlayListResponseModel extends BaseProtocol {
  String resultCode;
  String playListId;
  String playListName;
  String editStat;

  AddFavoritePlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playListId = arg['playListId'].toString();
    playListName = arg['playListName'].toString();
    editStat = arg['editStat'].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.4删除自建歌单
class DelFavoritePlayListResponseModel extends BaseProtocol {
  String resultCode;
  String playListId;

  DelFavoritePlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playListId = arg['playListId'].toString();
  }
}

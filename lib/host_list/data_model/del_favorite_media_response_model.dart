import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.10将歌曲从指定的自建歌单中取消收藏
class DelFavoriteMediaResponseModel extends BaseProtocol {
  String resultCode;
  String playListId;
  String mediaSrc;

  DelFavoriteMediaResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playListId = arg['playListId'].toString();
    mediaSrc = arg['mediaSrc'].toString();
  }
}

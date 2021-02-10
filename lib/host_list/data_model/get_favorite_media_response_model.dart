import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.12获取指定的自建歌单的歌曲列表
class GetFavoriteMediaResponseModel extends BaseProtocol {
  String resultCode;
  List mediaList;

  GetFavoriteMediaResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    mediaList = arg['mediaList'];
  }
}

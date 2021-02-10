import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.1获取自建歌单列表
class GetFavoritePlayListResponseModel extends BaseProtocol {
  String resultCode;
  List playList;

  GetFavoritePlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playList = arg['playList'];
  }
}

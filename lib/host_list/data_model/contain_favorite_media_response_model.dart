import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.13判断歌曲是否已收藏
class ContainFavoriteMediaResponseModel extends BaseProtocol {
  String resultCode;
  String contain;

  ContainFavoriteMediaResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    contain = arg['contain'].toString();
  }
}

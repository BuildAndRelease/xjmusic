import 'package:xj_music/broadcast/base_protocol.dart';

//播放列表的升降序模式
class PlayListModeResponseModel extends BaseProtocol {
  String resultCode;
  String isAsc;

  PlayListModeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    isAsc = arg['isAsc'].toString();
  }
}

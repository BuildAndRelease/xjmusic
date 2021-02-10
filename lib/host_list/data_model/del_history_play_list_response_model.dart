import 'package:xj_music/broadcast/base_protocol.dart';

//4.17.10删除历史播放列表
class DelHistoryPlayListResponseModel extends BaseProtocol {
  String resultCode;
  String mediaSrc;

  DelHistoryPlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    mediaSrc = arg['mediaSrc'].toString();
  }
}

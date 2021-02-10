import 'package:xj_music/broadcast/base_protocol.dart';

//4.17.1播放当前播放列表
class PlayCurrentPlayListResponseModel extends BaseProtocol {
  String resultCode;
  String playResult;

  PlayCurrentPlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playResult = arg['playResult'].toString();
  }
}

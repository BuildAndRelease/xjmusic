import 'package:xj_music/broadcast/base_protocol.dart';

//播放模式
class PlayModeResponseModel extends BaseProtocol {
  String resultCode;
  String playMode;

  PlayModeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playMode = arg['playMode'].toString();
  }
}

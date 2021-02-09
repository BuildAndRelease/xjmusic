import 'package:xj_music/broadcast/base_protocol.dart';

//播放音乐
class PlayMusicResponseModel extends BaseProtocol {
  String resultCode;
  String playResult;

  PlayMusicResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playResult = arg['playResult'].toString();
  }
}

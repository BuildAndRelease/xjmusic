import 'package:xj_music/broadcast/base_protocol.dart';

//播放命令
class PlayCmdResponseModel extends BaseProtocol {
  String resultCode;
  String playCmd;

  PlayCmdResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playCmd = arg['playCmd'].toString();
  }
}

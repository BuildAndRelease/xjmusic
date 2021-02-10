import 'package:xj_music/broadcast/base_protocol.dart';

//当前播放时间
class PlayTimeResponseModel extends BaseProtocol {
  String resultCode;
  String playTime;

  PlayTimeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playTime = arg['playTime'].toString();
  }
}

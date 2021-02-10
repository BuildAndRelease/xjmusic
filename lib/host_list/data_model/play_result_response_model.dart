import 'package:xj_music/broadcast/base_protocol.dart';

//播放结果
class PlayResultResponseModel extends BaseProtocol {
  String resultCode;
  String playResult;

  PlayResultResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playResult = arg['playResult'].toString();
  }
}

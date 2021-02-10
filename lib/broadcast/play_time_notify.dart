import 'package:xj_music/broadcast/base_protocol.dart';

//4.16.3当前播放时间通知
class PlayTimeNotify extends BaseProtocol {
  String playTime;
  PlayTimeNotify(Map json) : super(json) {
    playTime = arg["playTime"].toString();
  }
}

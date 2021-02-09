import 'package:xj_music/broadcast/base_protocol.dart';

//4.12.3播放模式更改通知
class PlayModeNotify extends BaseProtocol {
  String playMode;
  PlayModeNotify(Map json) : super(json) {
    playMode = arg["playMode"].toString();
  }
}

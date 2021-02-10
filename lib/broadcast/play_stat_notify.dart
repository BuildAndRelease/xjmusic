import 'package:xj_music/broadcast/base_protocol.dart';

//4.15.10播放状态发生改变时的通知
class PlayStatNotify extends BaseProtocol {
  String playStat;
  PlayStatNotify(Map json) : super(json) {
    playStat = arg["playStat"].toString();
  }
}

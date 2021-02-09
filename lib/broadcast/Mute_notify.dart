import 'package:xj_music/broadcast/base_protocol.dart';

//4.11.3静音通知
class MuteNotify extends BaseProtocol {
  String muteStat;
  MuteNotify(Map json) : super(json) {
    muteStat = arg["muteStat"].toString();
  }
}

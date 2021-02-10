import 'package:xj_music/broadcast/base_protocol.dart';

// 删除定时器通知
class DelTimerNotify extends BaseProtocol {
  String timerId;
  DelTimerNotify(Map json) : super(json) {
    timerId = arg["timerId"].toString();
  }
}

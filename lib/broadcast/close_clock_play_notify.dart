import 'package:xj_music/broadcast/base_protocol.dart';

//4.25.7关闭闹钟 广播
class CloseClockPlayNotify extends BaseProtocol {
  String timerId;
  CloseClockPlayNotify(Map json) : super(json) {
    timerId = arg["timerId"].toString();
  }
}

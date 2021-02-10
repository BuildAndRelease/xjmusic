import 'package:xj_music/broadcast/base_protocol.dart';

//4.25.4删除定时器
class TimerIdResponseModel extends BaseProtocol {
  String resultCode;
  String timerId;

  TimerIdResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    timerId = arg['timerId'].toString();
  }
}

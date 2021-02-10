import 'package:xj_music/broadcast/base_protocol.dart';

//4.25.9获取延时关机定时器
class GetDelayCloseTimerResponseModel extends BaseProtocol {
  String resultCode;
  String timerEnable;
  String remainTime;
  String delayCloseAfterTimes;

  GetDelayCloseTimerResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    timerEnable = arg['timerEnable'].toString();
    remainTime = arg['remainTime'].toString();
    delayCloseAfterTimes = arg['delayCloseAfterTimes'].toString();
  }
}

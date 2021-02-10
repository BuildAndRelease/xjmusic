import 'package:xj_music/broadcast/base_protocol.dart';

//4.25.10修改延时关机定时器
class ModifyDelayCloseTimerResponseModel extends BaseProtocol {
  String resultCode;
  String timerEnable;
  String delayCloseAfterTimes;

  ModifyDelayCloseTimerResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    timerEnable = arg['timerEnable'].toString();
    delayCloseAfterTimes = arg['delayCloseAfterTimes'].toString();
  }
}

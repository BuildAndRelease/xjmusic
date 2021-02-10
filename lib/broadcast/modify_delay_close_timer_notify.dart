import 'package:xj_music/broadcast/base_protocol.dart';

//4.25.11修改延时关机定时器通知
class ModifyDelayCloseTimerNotify extends BaseProtocol {
  String timerEnable;
  String delayCloseAfterTimes;
  ModifyDelayCloseTimerNotify(Map json) : super(json) {
    timerEnable = arg["timerEnable"].toString();
    delayCloseAfterTimes = arg["delayCloseAfterTimes"].toString();
  }
}

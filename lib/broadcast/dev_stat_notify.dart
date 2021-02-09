import 'package:xj_music/broadcast/base_protocol.dart';

//4.6.3开关机状态更改通知
class DevStatNotify extends BaseProtocol {
  String devStat;

  DevStatNotify(Map json) : super(json) {
    devStat = arg["devStat"].toString();
  }
}

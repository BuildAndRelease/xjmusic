import 'package:xj_music/broadcast/base_protocol.dart';

//4.22.4网络状态通知
class NetStatNotify extends BaseProtocol {
  String netStat;
  NetStatNotify(Map json) : super(json) {
    netStat = arg["netStat"].toString();
  }
}

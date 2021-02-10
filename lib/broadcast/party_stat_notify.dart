import 'package:xj_music/broadcast/base_protocol.dart';

//4.23.2party组状态更改通知
class NetStatNotify extends BaseProtocol {
  String partyStat;
  NetStatNotify(Map json) : super(json) {
    partyStat = arg["partyStat"].toString();
  }
}

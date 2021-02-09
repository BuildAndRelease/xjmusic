import 'package:xj_music/broadcast/base_protocol.dart';

//4.10.3高音更改通知
class TrebleNotify extends BaseProtocol {
  String treb;
  TrebleNotify(Map json) : super(json) {
    treb = arg["bass"].toString();
  }
}

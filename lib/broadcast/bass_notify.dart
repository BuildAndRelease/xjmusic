import 'package:xj_music/broadcast/base_protocol.dart';

//4.9.3低音更改通知
class BassNotify extends BaseProtocol {
  String bass;
  BassNotify(Map json) : super(json) {
    bass = arg["bass"].toString();
  }
}

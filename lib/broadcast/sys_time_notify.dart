import 'package:xj_music/broadcast/base_protocol.dart';

//4.13.3当前系统时间修改通知
class SysTimeNotify extends BaseProtocol {
  String time;
  SysTimeNotify(Map json) : super(json) {
    time = arg["time"].toString();
  }
}

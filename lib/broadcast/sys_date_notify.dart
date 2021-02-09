import 'package:xj_music/broadcast/base_protocol.dart';

//4.14.3日期修改通知
class SysDateNotify extends BaseProtocol {
  String date;
  SysDateNotify(Map json) : super(json) {
    date = arg["date"].toString();
  }
}

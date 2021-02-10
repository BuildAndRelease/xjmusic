import 'package:xj_music/broadcast/base_protocol.dart';

//4.27.3设置系统主机名称通知
class SystemServerNameNotify extends BaseProtocol {
  String serverName;

  SystemServerNameNotify(Map json) : super(json) {
    serverName = arg['serverName'].toString();
  }
}

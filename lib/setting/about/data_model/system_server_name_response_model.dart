import 'package:xj_music/broadcast/base_protocol.dart';

//系统主机名称
class SystemServerNameResponseModel extends BaseProtocol {
  String resultCode;
  String serverName;

  SystemServerNameResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    serverName = arg['serverName'].toString();
  }
}

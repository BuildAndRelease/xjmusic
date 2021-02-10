import 'package:xj_music/broadcast/base_protocol.dart';

//主机IP信息
class ServerIpInfoResponseModel extends BaseProtocol {
  String resultCode;
  String autoSetIp;
  String address;
  String gateway;
  String netmask;
  String dns1;
  String dns2;

  ServerIpInfoResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    autoSetIp = arg['autoSetIp'].toString();
    address = arg['address'].toString();
    gateway = arg['gateway'].toString();
    netmask = arg['netmask'].toString();
    dns1 = arg['dns1'].toString();
    dns2 = arg['dns2'].toString();
  }
}

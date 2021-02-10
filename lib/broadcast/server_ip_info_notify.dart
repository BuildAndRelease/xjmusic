import 'package:xj_music/broadcast/base_protocol.dart';

//4.28.3设置主机IP信息通知
class ServerIpInfoNotify extends BaseProtocol {
  String autoSetIp;
  String address;
  String gateway;
  String netmask;
  String dns1;
  String dns2;
  ServerIpInfoNotify(Map json) : super(json) {
    autoSetIp = arg['autoSetIp'].toString();
    address = arg['address'].toString();
    gateway = arg['gateway'].toString();
    netmask = arg['netmask'].toString();
    dns1 = arg['dns1'].toString();
    dns2 = arg['dns2'].toString();
  }
}

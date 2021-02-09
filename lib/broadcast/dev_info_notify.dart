import 'package:xj_music/broadcast/base_protocol.dart';

class DevInfoNotify extends BaseProtocol {
  String devName;
  String softVer;
  String hardVer;
  DevInfoNotify(Map json) : super(json) {
    devName = arg['devName'].toString();
    softVer = arg['softVer'].toString();
    hardVer = arg['hardVer'].toString();
  }
}

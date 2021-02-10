import 'package:xj_music/broadcast/base_protocol.dart';

//4.5.1获取设备信息
class GetDevInfoResponseModel extends BaseProtocol {
  String resultCode;
  String devName;
  String softVer;
  String hardVer;

  GetDevInfoResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    devName = arg['devName'].toString();
    softVer = arg['softVer'].toString();
    hardVer = arg['hardVer'].toString();
  }
}

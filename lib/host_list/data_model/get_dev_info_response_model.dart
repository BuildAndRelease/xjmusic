import 'package:xj_music/broadcast/base_protocol.dart';

//4.5.1获取设备信息
class GetDevInfoResponseModel extends BaseProtocol {
  String resultCode;
  String devName;
  String softVer;
  String hardVer;

  GetDevInfoResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'];
    devName = arg['devName'];
    softVer = arg['softVer'];
    hardVer = arg['hardVer'];
  }
}

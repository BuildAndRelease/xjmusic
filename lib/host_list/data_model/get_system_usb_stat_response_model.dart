import 'package:xj_music/broadcast/base_protocol.dart';

//4.22.1Usb/SD热拔插设备拔插状态获取
class GetSystemUsbStatResponseModel extends BaseProtocol {
  String resultCode;
  String usbStat;
  String tfStat;

  GetSystemUsbStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    usbStat = arg['usbStat'].toString();
    tfStat = arg['tfStat'].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.22.2Usb/SD热拔插设备拔插状态通知
class SystemUsbStatNotify extends BaseProtocol {
  String usbStat;
  String tfStat;
  SystemUsbStatNotify(Map json) : super(json) {
    usbStat = arg["usbStat"].toString();
    tfStat = arg["tfStat"].toString();
  }
}

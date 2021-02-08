import 'package:xj_music/broadcast/base_protocol.dart';

class SearchHostNotify extends BaseProtocol {
  String resultCode;
  String deviceType;
  String deviceId;
  String deviceName;
  String deviceVersion;
  String deviceIp;
  String barcode;
  SearchHostNotify(Map json) : super(json) {
    resultCode = arg["resultCode"].toString();
    deviceType = arg["deviceType"].toString();
    deviceId = arg["deviceId"].toString();
    deviceName = arg["deviceName"].toString();
    deviceVersion = arg["deviceVersion"].toString();
    deviceIp = arg["deviceIp"].toString();
    barcode = arg["barcode"].toString();
  }
}

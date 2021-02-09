import 'package:xj_music/broadcast/base_protocol.dart';

//4.7.1获取音量
class VolumeResponseModel extends BaseProtocol {
  String resultCode;
  String volume;

  VolumeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    volume = arg['volume'].toString();
  }
}

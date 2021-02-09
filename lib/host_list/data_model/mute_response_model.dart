import 'package:xj_music/broadcast/base_protocol.dart';

//静音
class MuteResponseModel extends BaseProtocol {
  String resultCode;
  String muteStat;

  MuteResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    muteStat = arg['muteStat'].toString();
  }
}

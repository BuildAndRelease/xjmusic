import 'package:xj_music/broadcast/base_protocol.dart';

//低音
class BassResponseModel extends BaseProtocol {
  String resultCode;
  String bass;

  BassResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    bass = arg['bass'].toString();
  }
}

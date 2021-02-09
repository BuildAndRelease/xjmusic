import 'package:xj_music/broadcast/base_protocol.dart';

//高音
class TrebleResponseModel extends BaseProtocol {
  String resultCode;
  String treb;

  TrebleResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    treb = arg['treb'].toString();
  }
}

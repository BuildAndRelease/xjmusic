import 'package:xj_music/broadcast/base_protocol.dart';

//4.6.4房间全开/全关
class SetAllDevStatResponseModel extends BaseProtocol {
  String resultCode;
  String devStat;

  SetAllDevStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    devStat = arg['devStat'].toString();
  }
}

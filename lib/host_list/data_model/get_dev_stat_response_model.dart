import 'package:xj_music/broadcast/base_protocol.dart';

//4.6.1获取设备开关机状态
class GetDevStatResponseModel extends BaseProtocol {
  String resultCode;
  String devStat;

  GetDevStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    devStat = arg['devStat'].toString();
  }
}

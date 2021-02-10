import 'package:xj_music/broadcast/base_protocol.dart';

//4.22.3网络状态获取
class GetNetStatResponseModel extends BaseProtocol {
  String resultCode;
  String netStat;

  GetNetStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    netStat = arg['netStat'].toString();
  }
}

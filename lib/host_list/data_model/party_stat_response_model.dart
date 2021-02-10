import 'package:xj_music/broadcast/base_protocol.dart';

//party组
class PartyStatResponseModel extends BaseProtocol {
  String resultCode;
  String partyStat;

  PartyStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    partyStat = arg['partyStat'].toString();
  }
}

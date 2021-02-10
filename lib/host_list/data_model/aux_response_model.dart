import 'package:xj_music/broadcast/base_protocol.dart';

//Aux
class AuxResponseModel extends BaseProtocol {
  String resultCode;
  String auxId;

  AuxResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    auxId = arg['auxId'].toString();
  }
}

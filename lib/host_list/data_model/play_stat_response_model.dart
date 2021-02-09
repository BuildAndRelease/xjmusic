import 'package:xj_music/broadcast/base_protocol.dart';

//音源
class PlayStatResponseModel extends BaseProtocol {
  String resultCode;
  String playStat;

  PlayStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playStat = arg['playStat'].toString();
  }
}

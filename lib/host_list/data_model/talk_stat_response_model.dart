import 'package:xj_music/broadcast/base_protocol.dart';

//讨论组状态
class TalkStatResponseModel extends BaseProtocol {
  String resultCode;
  String talkId;
  String talkName;
  String talkStat;
  String talkPort;
  String talkMulticastIp;

  TalkStatResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkId = arg['talkId'].toString();
    talkName = arg['talkName'].toString();
    talkStat = arg['talkStat'].toString();
    talkPort = arg['talkPort'].toString();
    talkMulticastIp = arg['talkMulticastIp'].toString();
  }
}

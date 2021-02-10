import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.16房间对讲状态改变通知
class TalkingStatNotify extends BaseProtocol {
  String talkId;
  String talkingStat;
  TalkingStatNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
    talkingStat = arg["talkingStat"].toString();
  }
}

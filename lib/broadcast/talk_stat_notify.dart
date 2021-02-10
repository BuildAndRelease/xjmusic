import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.14对讲组开启/关闭通知
class TalkStatNotify extends BaseProtocol {
  String talkId;
  String talkStat;
  TalkStatNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
    talkStat = arg["talkStat"].toString();
  }
}

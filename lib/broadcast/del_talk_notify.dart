import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.5删除对讲组通知
class DelTalkNotify extends BaseProtocol {
  String talkId;
  DelTalkNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.7重命名对讲组通知
class RenameTalkNotify extends BaseProtocol {
  String talkId;
  String talkName;
  RenameTalkNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
    talkName = arg["talkName"].toString();
  }
}

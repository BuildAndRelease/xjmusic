import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.4删除对讲组
class DelTalkResponseModel extends BaseProtocol {
  String resultCode;
  String talkId;

  DelTalkResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkId = arg['talkId'].toString();
  }
}

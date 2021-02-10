import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.6重命名对讲组
class RenameTalkResponseModel extends BaseProtocol {
  String resultCode;
  String talkId;
  String talkName;

  RenameTalkResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkId = arg['talkId'].toString();
    talkName = arg['talkName'].toString();
  }
}

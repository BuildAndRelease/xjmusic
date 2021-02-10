import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.2新建对讲组
class AddTalkResponseModel extends BaseProtocol {
  String resultCode;
  String talkName;
  String talkId;
  List talkRoom;

  AddTalkResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkName = arg['talkName'].toString();
    talkId = arg['talkId'].toString();
    talkRoom = arg['talkRoom'];
  }

  get talkRoomCount => talkRoom.length;

  String talkRoomAtIndex(int index) {
    return talkRoom[index];
  }
}

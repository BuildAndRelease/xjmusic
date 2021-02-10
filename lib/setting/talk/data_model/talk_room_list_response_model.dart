import 'package:xj_music/broadcast/base_protocol.dart';

//talkroomlist
class TalkRoomListResponseModel extends BaseProtocol {
  String resultCode;
  String talkId;
  List talkRooms;

  TalkRoomListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkId = arg['talkId'].toString();
    talkRooms = arg['talkRoom'];
  }

  get talkRoomsCount => talkRooms.length;

  String talkRoomsAtIndex(int index) {
    return talkRooms[index];
  }
}

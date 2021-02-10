import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.12指定房间从指定对讲组中删除的通知
class DelTalkRoomNotify extends BaseProtocol {
  String talkId;
  List talkRooms;
  DelTalkRoomNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
    talkRooms = arg["talkRoom"];
  }
  get talkRoomsCount => talkRooms.length;

  String talkRoomsAtIndex(int index) {
    return talkRooms[index];
  }
}

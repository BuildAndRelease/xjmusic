import 'package:xj_music/broadcast/add_talk_notify.dart';
import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.10指定房间加入指定对讲组的通知
class AddTalkRoomNotify extends BaseProtocol {
  String talkId;
  List talkRooms;
  AddTalkRoomNotify(Map json) : super(json) {
    talkId = arg["talkId"].toString();
    talkRooms = arg["talkRoom"];
  }
  get talkRoomsCount => talkRooms.length;

  Room talkRoomsAtIndex(int index) {
    return Room.fromJson(talkRooms[index]);
  }
}

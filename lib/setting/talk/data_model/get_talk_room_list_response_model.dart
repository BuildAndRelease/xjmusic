import 'package:xj_music/broadcast/add_talk_notify.dart';
import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.8获取指定对讲组房间成员
class GetTalkRoomListResponseModel extends BaseProtocol {
  String resultCode;
  List rooms;

  GetTalkRoomListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    rooms = arg['room'];
  }

  get roomsCount => rooms.length;

  Room roomsAtIndex(int index) {
    return Room.fromJson(rooms[index]);
  }
}

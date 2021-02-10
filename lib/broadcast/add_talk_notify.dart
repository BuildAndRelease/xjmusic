import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.3新建对讲组通知
class AddTalkNotify extends BaseProtocol {
  String talkName;
  String talkId;
  List talkRooms;
  AddTalkNotify(Map json) : super(json) {
    talkName = arg["talkName"].toString();
    talkId = arg["talkId"].toString();
    talkRooms = arg["talkRoom"];
  }
  get talkRoomsCount => talkRooms.length;

  Room talkRoomsAtIndex(int index) {
    return Room.fromJson(talkRooms[index]);
  }
}

class Room {
  String roomName;
  String roomId;
  String talkStat;
  String talkId;

  Room({this.roomName, this.roomId, this.talkStat, this.talkId});

  Room.fromJson(Map json) {
    roomName = json['roomName'].toString();
    roomId = json['roomId'].toString();
    talkStat = json['talkStat'].toString();
    talkId = json['talkId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomName'] = this.roomName;
    data['roomId'] = this.roomId;
    data['talkStat'] = this.talkStat;
    data['talkId'] = this.talkId;
    return data;
  }
}

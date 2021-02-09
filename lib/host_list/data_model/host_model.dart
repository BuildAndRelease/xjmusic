import 'package:xj_music/broadcast/base_protocol.dart';

class GetHostRoomListResponseModel extends BaseProtocol {
  String resultCode;
  String hostId;
  List roomList;

  GetHostRoomListResponseModel(Map json) : super(json) {
    resultCode = arg["resultCode"].toString();
    hostId = arg["hostId"].toString();
    roomList = arg["roomList"];
  }

  get roomListCount => roomList?.length ?? 0;

  GetHostRoomInfoResponseModel roomInfoAtIndex(int index) {
    return GetHostRoomInfoResponseModel(roomList[index]);
  }
}

class GetHostRoomInfoResponseModel {
  Map json;
  String roomName;
  String roomId;
  String devStat;
  String channelStat;
  String playStat;
  String playName;
  String serialId;

  GetHostRoomInfoResponseModel(Map json) {
    this.json = json;
    roomName = json["roomName"];
    roomId = json["roomId"];
    devStat = json["devStat"];
    channelStat = json["channelStat"];
    playStat = json["playStat"];
    playName = json["playName"];
    serialId = json["serialId"];
  }

  void modifyDevStat(String stat) {
    json["devStat"] = stat;
  }
}

class SetDevStatResponseModel extends BaseProtocol {
  String resultCode;
  String devStat;

  SetDevStatResponseModel(Map json) : super(json) {
    resultCode = arg["resultCode"].toString();
    devStat = arg["devStat"].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_playing_info_response_model.dart';

//4.4.3获取当前房间的基本状态信息（用于一次性获取较多的信息）
class GetRoomStatInfoResponseModel extends BaseProtocol {
  String resultCode;
  String devStat;
  String playStat;
  String volume;
  String playMode;
  String roomStat;
  String playTime;
  String muteStat;
  BasicMedia media;

  GetRoomStatInfoResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'];
    devStat = arg['devStat'];
    playStat = arg['playStat'];
    volume = arg['volume'];
    playMode = arg['playMode'];
    roomStat = arg['roomStat'];
    playTime = arg['playTime'];
    muteStat = arg['muteStat'];
    media = arg['media'];
    switch (arg["media"]["mediaSrc"]) {
      case "cloudMusic":
        media = CloudMusicMedia.fromJson(arg["media"]);
        break;
      case "cloudStoryTelling":
        media = CloudStoryTellingMedia.fromJson(arg["media"]);
        break;
      case "localMusic":
        media = LocalMusicMedia.fromJson(arg["media"]);
        break;
      case "localAux":
        media = LocalAuxMedia.fromJson(arg["media"]);
        break;
      case "cloudNetFm":
        media = CloudNetFmMedia.fromJson(arg["media"]);
        break;
      default:
        media = null;
        break;
    }
  }
}

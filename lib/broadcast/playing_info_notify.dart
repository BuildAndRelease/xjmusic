import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//4.4.2房间信息变更通知
class PlayingInfoNotify extends BaseProtocol {
  String roomStat;
  String talkId;
  String partyId;
  BasicMedia media;

  PlayingInfoNotify(Map json) : super(json) {
    roomStat = arg["roomStat"].toString();
    switch (roomStat) {
      case "inTalk":
        talkId = arg["talkId"].toString();
        break;
      case "inParty":
        partyId = arg["partyId"].toString();
        continue inNormal;
      inNormal:
      case "inNormal":
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
        break;
      case "inDlna":
        break;
      case "inAirplay":
        break;
      default:
    }
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//4.25.3添加定时器通知
class AddTimerNotify extends BaseProtocol {
  String timerId;
  String timerName;
  String timerEnable;
  String circleDay;
  String actionName;
  String specialDate;
  String preSetTime;
  BasicMedia media;

  AddTimerNotify(Map json) : super(json) {
    timerId = arg['timerId'].toString();
    timerName = arg['timerName'].toString();
    timerEnable = arg['timerEnable'].toString();
    circleDay = arg['circleDay'].toString();
    actionName = arg['actionName'].toString();
    specialDate = arg['specialDate'].toString();
    preSetTime = arg['preSetTime'].toString();

    switch (arg['media']["mediaSrc"]) {
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

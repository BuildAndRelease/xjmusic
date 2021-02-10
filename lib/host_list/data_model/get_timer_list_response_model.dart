import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//4.24.1获取对讲组列表
class GetTimerListResponseModel extends BaseProtocol {
  String resultCode;
  List timerList;

  GetTimerListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    timerList = arg['timerList'];
  }

  get timerListCount => timerList.length;

  Timer timerListAtIndex(int index) {
    return Timer.fromJson(timerList[index]);
  }
}

class Timer {
  String timerId;
  String timerName;
  String timerEnable;
  String circleDay;
  String preSetTime;
  String specialDate;
  String actionName;
  String remainTime;
  String volume;
  String clockTime;
  BasicMedia media;

  Timer(
      {this.timerId,
      this.timerName,
      this.timerEnable,
      this.circleDay,
      this.preSetTime,
      this.specialDate,
      this.actionName,
      this.remainTime,
      this.volume,
      this.clockTime,
      this.media});

  Timer.fromJson(Map json) {
    timerId = json['timerId'].toString();
    timerName = json['timerName'].toString();
    timerEnable = json['timerEnable'].toString();
    circleDay = json['circleDay'].toString();
    preSetTime = json['preSetTime'].toString();
    specialDate = json['specialDate'].toString();
    actionName = json['actionName'].toString();
    remainTime = json['remainTime'].toString();
    volume = json['volume'].toString();
    clockTime = json['clockTime'].toString();

    switch (json['media']["mediaSrc"]) {
      case "cloudMusic":
        media = CloudMusicMedia.fromJson(json["media"]);
        break;
      case "cloudStoryTelling":
        media = CloudStoryTellingMedia.fromJson(json["media"]);
        break;
      case "localMusic":
        media = LocalMusicMedia.fromJson(json["media"]);
        break;
      case "localAux":
        media = LocalAuxMedia.fromJson(json["media"]);
        break;
      case "cloudNetFm":
        media = CloudNetFmMedia.fromJson(json["media"]);
        break;
      default:
        media = null;
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timerId'] = this.timerId;
    data['timerName'] = this.timerName;
    data['timerEnable'] = this.timerEnable;
    data['circleDay'] = this.circleDay;
    data['preSetTime'] = this.preSetTime;
    data['specialDate'] = this.specialDate;
    data['actionName'] = this.actionName;
    data['remainTime'] = this.remainTime;
    data['volume'] = this.volume;
    data['clockTime'] = this.clockTime;
    data['media'] = this.media;
    return data;
  }
}

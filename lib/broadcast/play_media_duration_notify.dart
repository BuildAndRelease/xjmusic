import 'package:xj_music/broadcast/base_protocol.dart';

//4.18当前播放信息的总时长(需要用加载数据后，才知道媒体时长)
class PlayingMediaDurationNotify extends BaseProtocol {
  String duration;
  PlayingMediaDurationNotify(Map json) : super(json) {
    duration = arg["duration"].toString();
  }
}

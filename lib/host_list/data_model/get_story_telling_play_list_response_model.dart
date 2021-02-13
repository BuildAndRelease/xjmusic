import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.3.4获取语言节目的播放列表
class GetStorytellingPlaylistResponseModel extends BaseProtocol {
  List<CloudStoryTellingMedia> mediaPlayList;
  String resultCode;
  String total;

  GetStorytellingPlaylistResponseModel(Map json) : super(json) {
    if (json['mediaPlayList'] != null) {
      mediaPlayList = <CloudStoryTellingMedia>[];
      json['mediaPlayList'].forEach((v) {
        mediaPlayList.add(new CloudStoryTellingMedia.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    total = json['total'].toString();
  }
  get mediaPlayListCount => mediaPlayList.length;
  CloudStoryTellingMedia mediaPlayListAtIndex(int index) {
    return mediaPlayList[index];
  }
}

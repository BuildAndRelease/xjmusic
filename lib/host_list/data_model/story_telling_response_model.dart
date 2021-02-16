import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//语言节目列表
class StorytellingResponseModel extends BaseProtocol {
  List<CloudStoryTellingMedia> mediaList;
  String resultCode;
  String total;

  StorytellingResponseModel(Map json) : super(json) {
    if (json['mediaList'] != null) {
      mediaList = <CloudStoryTellingMedia>[];
      json['mediaList'].forEach((v) {
        mediaList.add(new CloudStoryTellingMedia.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    total = json['total'].toString();
  }
  get mediaListCount => mediaList?.length ?? 0;
  CloudStoryTellingMedia mediaListAtIndex(int index) {
    return mediaList[index];
  }
}

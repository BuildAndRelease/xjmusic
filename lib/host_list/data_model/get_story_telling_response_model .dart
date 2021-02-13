import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_favorite_set_response_model.dart';

//5.3.2获取分类下的语言节目
class GetStorytellingResponseModel extends BaseProtocol {
  List<StoryTellingAlbumSet> mediaList;
  String resultCode;
  String total;

  GetStorytellingResponseModel(Map json) : super(json) {
    if (json['mediaList'] != null) {
      mediaList = <StoryTellingAlbumSet>[];
      json['mediaList'].forEach((v) {
        mediaList.add(new StoryTellingAlbumSet.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    total = json['total'].toString();
  }
  get mediaListCount => mediaList.length;
  StoryTellingAlbumSet mediaListAtIndex(int index) {
    return mediaList[index];
  }
}

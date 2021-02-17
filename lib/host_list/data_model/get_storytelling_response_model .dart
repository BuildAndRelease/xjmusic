import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_favorite_set_response_model.dart';

//5.3.2获取分类下的语言节目
class GetStorytellingResponseModel extends BaseProtocol {
  List<StoryTellingAlbumSet> mediaList;
  String resultCode;
  String total;

  GetStorytellingResponseModel(Map json) : super(json) {
    if (arg['mediaList'] != null) {
      mediaList = <StoryTellingAlbumSet>[];
      arg['mediaList'].forEach((v) {
        mediaList.add(new StoryTellingAlbumSet.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
    total = arg['total'].toString();
  }
  get mediaListCount => mediaList?.length ?? 0;
  StoryTellingAlbumSet mediaListAtIndex(int index) {
    return mediaList[index];
  }

  void combineMoreData(GetStorytellingResponseModel dataModel) {
    mediaList.addAll(dataModel.mediaList);
  }
}

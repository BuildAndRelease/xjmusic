//5.3.2获取分类下的语言节目
import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_favorite_set_response_model.dart';

class GetStorytellingRankAlbumListResponseModel extends BaseProtocol {
  List<StoryTellingAlbumSet> mediaList;
  String resultCode;
  String total;

  GetStorytellingRankAlbumListResponseModel(Map json) : super(json) {
    if (arg['list'] != null) {
      mediaList = <StoryTellingAlbumSet>[];
      arg['list'].forEach((v) {
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

  void combineMoreData(GetStorytellingRankAlbumListResponseModel dataModel) {
    mediaList.addAll(dataModel.mediaList);
  }
}

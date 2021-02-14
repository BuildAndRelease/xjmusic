import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_playing_info_response_model.dart';

//4.17.9获取历史播放列表
class GetHistoryPlayListResponseModel extends BaseProtocol {
  String resultCode;
  String mediaSrc;
  String total;
  String pageNum;
  String pageSize;
  List mediaList;

  GetHistoryPlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    mediaSrc = arg['mediaSrc'].toString();
    total = arg['total'].toString();
    pageNum = arg['pageNum'].toString();
    pageSize = arg['pageSize'].toString();
    mediaList = arg['mediaList'];
  }
  get mediaListCount => mediaList.length;

  BasicMedia mediaListAtIndex(int index) {
    BasicMedia media;
    switch (mediaList[index]["mediaSrc"]) {
      case "cloudMusic":
        media = CloudMusicMedia.fromJson(mediaList[index]);
        break;
      case "cloudStoryTelling":
        media = CloudStoryTellingMedia.fromJson(mediaList[index]);
        break;
      case "localMusic":
        media = LocalMusicMedia.fromJson(mediaList[index]);
        break;
      case "localAux":
        media = LocalAuxMedia.fromJson(mediaList[index]);
        break;
      case "cloudNetFm":
        media = CloudNetFmMedia.fromJson(mediaList[index]);
        break;
      default:
        media = null;
        break;
    }
    return media;
  }

  void combineMoreData(GetHistoryPlayListResponseModel dataModel) {
    mediaList.addAll(dataModel.mediaList);
  }
}

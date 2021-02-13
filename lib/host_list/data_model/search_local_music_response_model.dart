import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_playing_info_response_model.dart';

//5.1.2搜索本地歌曲
class SearchLocalMusicResponseModel extends BaseProtocol {
  String resultCode;
  String beginIndex;
  String num;
  String total;
  List mediaList;

  SearchLocalMusicResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    beginIndex = arg['beginIndex'].toString();
    num = arg['num'].toString();
    total = arg['total'].toString();
    mediaList = arg['mediaList'];
  }
  get mediaListCount => mediaList.length;

  BasicMedia mediaListAtIndex(int index) {
    BasicMedia media;
    switch (mediaList[index]["mediaSrc"]) {
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
    return media;
  }
}

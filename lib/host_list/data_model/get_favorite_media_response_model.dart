import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_playing_info_response_model.dart';

//4.19.12获取指定的自建歌单的歌曲列表
class GetFavoriteMediaResponseModel extends BaseProtocol {
  String resultCode;
  List mediaList;

  GetFavoriteMediaResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
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

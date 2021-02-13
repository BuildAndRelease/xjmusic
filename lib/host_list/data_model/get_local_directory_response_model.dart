import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_playing_info_response_model.dart';

//5.1.1获取指定目录的信息
class GetLocalDirectoryResponseModel extends BaseProtocol {
  String resultCode;
  String beginIndex;
  String num;
  String total;
  List directoryList;
  List mediaList;

  GetLocalDirectoryResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    beginIndex = arg['beginIndex'].toString();
    num = arg['num'].toString();
    total = arg['total'].toString();
    directoryList = arg['directoryList'];
    mediaList = arg['mediaList'];
  }
  get directoryListCount => directoryList.length;
  get mediaListCount => mediaList.length;

  Node directoryListAtIndex(int index) {
    return Node.fromJson(directoryList[index]);
  }

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

class Node {
  String directoryMid;
  String directoryName;

  Node({this.directoryMid, this.directoryName});

  Node.fromJson(Map json) {
    directoryMid = json['directoryMid'].toString();
    directoryName = json['directoryName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directoryMid'] = this.directoryMid;
    data['directoryName'] = this.directoryName;
    return data;
  }
}

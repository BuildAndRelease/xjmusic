import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//4.29.8获取已下载或正在下载的列表
class DownloadedMusicListResponseModel extends BaseProtocol {
  String resultCode;
  String mediaSrc;
  List medialList;

  DownloadedMusicListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    mediaSrc = arg['mediaSrc'].toString();
    medialList = arg['medialList'];
  }

  get medialListCount => medialList.length;

  DownloadItem medialListAtIndex(int index) {
    return DownloadItem.fromJson(medialList[index]);
  }
}

class DownloadItem {
  String id;
  String mediaSrc;
  String mid;
  String downloadPath;
  String filePath;
  String state;
  String fileExist;
  BasicMedia media;

  DownloadItem(
      {this.id,
      this.mediaSrc,
      this.mid,
      this.downloadPath,
      this.filePath,
      this.state,
      this.fileExist,
      this.media});

  DownloadItem.fromJson(Map json) {
    id = json['id'].toString();
    mediaSrc = json['mediaSrc'].toString();
    mid = json['mid'].toString();
    downloadPath = json['downloadPath'].toString();
    filePath = json['filePath'].toString();
    state = json['state'].toString();
    fileExist = json['fileExist'].toString();

    switch (json['media']["mediaSrc"]) {
      case "cloudMusic":
        media = CloudMusicMedia.fromJson(json["media"]);
        break;
      case "cloudStoryTelling":
        media = CloudStoryTellingMedia.fromJson(json["media"]);
        break;
      case "localMusic":
        media = LocalMusicMedia.fromJson(json["media"]);
        break;
      case "localAux":
        media = LocalAuxMedia.fromJson(json["media"]);
        break;
      case "cloudNetFm":
        media = CloudNetFmMedia.fromJson(json["media"]);
        break;
      default:
        media = null;
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mediaSrc'] = this.mediaSrc;
    data['mid'] = this.mid;
    data['downloadPath'] = this.downloadPath;
    data['filePath'] = this.filePath;
    data['state'] = this.state;
    data['fileExist'] = this.fileExist;
    data['media'] = this.media;
    return data;
  }
}

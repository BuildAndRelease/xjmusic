import 'package:xj_music/broadcast/base_protocol.dart';

//4.29.1云资源下载
class DownloadMusicListResponseModel extends BaseProtocol {
  String resultCode;
  String downloadPath;

  DownloadMusicListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    downloadPath = arg['downloadPath'].toString();
  }
}

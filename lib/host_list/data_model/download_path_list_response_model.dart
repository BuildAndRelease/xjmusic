import 'package:xj_music/broadcast/base_protocol.dart';

//资源下载路径
class DownloadPathListResponseModel extends BaseProtocol {
  String resultCode;
  List downloadPathList;

  DownloadPathListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    downloadPathList = arg['downloadPathList'];
  }

  get downloadPathListCount => downloadPathList.length;

  String downloadPathListAtIndex(int index) {
    return downloadPathList[index];
  }
}

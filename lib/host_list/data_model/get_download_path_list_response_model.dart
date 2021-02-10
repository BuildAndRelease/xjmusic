import 'package:xj_music/broadcast/base_protocol.dart';

//4.29.3获取资源下载下载路径
class GetDownloadPathListResponseModel extends BaseProtocol {
  String resultCode;
  List downloadPathList;
  String defaultPath;

  GetDownloadPathListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    downloadPathList = arg['downloadPathList'];
    defaultPath = arg['defaultPath'].toString();
  }

  get downloadPathListCount => downloadPathList.length;

  String downloadPathListAtIndex(int index) {
    return downloadPathList[index];
  }
}

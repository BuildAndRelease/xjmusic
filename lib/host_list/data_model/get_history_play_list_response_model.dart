import 'package:xj_music/broadcast/base_protocol.dart';

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
}

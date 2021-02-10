import 'package:xj_music/broadcast/base_protocol.dart';

//4.17.2获取当前播放列表
class GetCurrentPlayListResponseModel extends BaseProtocol {
  String resultCode;
  String total;
  String pageNum;
  String pageSize;
  List mediaList;

  GetCurrentPlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    total = arg['total'].toString();
    pageNum = arg['pageNum'].toString();
    pageSize = arg['pageSize'].toString();
    mediaList = arg['mediaList'];
  }
}

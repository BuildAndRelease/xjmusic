import 'package:xj_music/broadcast/base_protocol.dart';

//媒体来源响应
class MediaSrcResponseModel extends BaseProtocol {
  String resultCode;
  String mediaSrc;

  MediaSrcResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    mediaSrc = arg['mediaSrc'].toString();
  }
}

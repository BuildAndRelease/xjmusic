import 'package:xj_music/broadcast/base_protocol.dart';

//4.29.6设置默认下载
class SetDefaultDownloadPathResponseModel extends BaseProtocol {
  String resultCode;
  String defaultPath;

  SetDefaultDownloadPathResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    defaultPath = arg['defaultPath'].toString();
  }
}

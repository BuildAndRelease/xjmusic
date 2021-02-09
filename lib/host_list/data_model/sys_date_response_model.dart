import 'package:xj_music/broadcast/base_protocol.dart';

//播放模式
class SysDateResponseModel extends BaseProtocol {
  String resultCode;
  String date;

  SysDateResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    date = arg['date'].toString();
  }
}

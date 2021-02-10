import 'package:xj_music/broadcast/base_protocol.dart';

//系统时间
class SysTimeResponseModel extends BaseProtocol {
  String resultCode;
  String time;

  SysTimeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    time = arg['time'].toString();
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.5.2设置设备信息[用于更改房间名称]
class SetDevInfoResponseModel extends BaseProtocol {
  String resultCode;
  String devName;

  SetDevInfoResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    devName = arg['devName'].toString();
  }
}

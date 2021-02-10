import 'package:xj_music/broadcast/base_protocol.dart';

//4.34.2开始升级
class StartSystemUpdateResponseModel extends BaseProtocol {
  String resultCode;
  String updateType;
  String updateVersion;

  StartSystemUpdateResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    updateType = arg['updateType'].toString();
    updateVersion = arg['updateVersion'].toString();
  }
}

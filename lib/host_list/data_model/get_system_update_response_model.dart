import 'package:xj_music/broadcast/base_protocol.dart';

//4.34.1获取系统升级信息
class GetSystemUpdateResponseModel extends BaseProtocol {
  String resultCode;
  String hasUpdate;
  String updateType;
  String updateVersion;
  String updateDes;

  GetSystemUpdateResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    hasUpdate = arg['hasUpdate'].toString();
    updateType = arg['updateType'].toString();
    updateVersion = arg['updateVersion'].toString();
    updateDes = arg['updateDes'].toString();
  }
}

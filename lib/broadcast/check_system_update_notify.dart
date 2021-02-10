import 'package:xj_music/broadcast/base_protocol.dart';

//4.34.4有升级信息的广播
class CheckSystemUpdateNotify extends BaseProtocol {
  String updateType;
  String updateVersion;
  String updateDes;
  CheckSystemUpdateNotify(Map json) : super(json) {
    updateType = arg["updateType"].toString();
    updateVersion = arg["updateVersion"].toString();
    updateDes = arg["updateDes"].toString();
  }
}

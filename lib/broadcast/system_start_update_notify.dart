import 'package:xj_music/broadcast/base_protocol.dart';

//4.34.3开始升级的广播
class SystemStartUpdateNotify extends BaseProtocol {
  String updateType;
  String updateVersion;
  SystemStartUpdateNotify(Map json) : super(json) {
    updateType = arg["updateType"].toString();
    updateVersion = arg["updateVersion"].toString();
  }
}

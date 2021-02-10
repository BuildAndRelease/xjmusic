import 'package:xj_music/broadcast/base_protocol.dart';

//4.29.7设置默认下载通知
class SetDefaultPathNotify extends BaseProtocol {
  String defaultPath;
  SetDefaultPathNotify(Map json) : super(json) {
    defaultPath = arg["defaultPath"].toString();
  }
}

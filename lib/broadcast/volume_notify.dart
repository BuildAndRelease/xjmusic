import 'package:xj_music/broadcast/base_protocol.dart';

class VolumeNotify extends BaseProtocol {
  String volume;
  VolumeNotify(Map json) : super(json) {
    volume = arg["volume"].toString();
  }
}

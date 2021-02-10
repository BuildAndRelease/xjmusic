import 'package:xj_music/broadcast/base_protocol.dart';

//4.31.3 音效均衡器通知
class MusicVolumeEqNotify extends BaseProtocol {
  String eqType;
  Map musicVolumeEq;

  MusicVolumeEqNotify(Map json) : super(json) {
    eqType = arg["eqType"].toString();
    musicVolumeEq = arg["musicVolumeEq"];
  }
}

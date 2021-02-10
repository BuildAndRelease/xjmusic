import 'package:xj_music/broadcast/base_protocol.dart';

//音效均衡器响应
class MusicVolumeEqResponseModel extends BaseProtocol {
  String resultCode;
  String eqType;
  Map musicVolumeEq;

  MusicVolumeEqResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    eqType = arg['eqType'].toString();
    musicVolumeEq = arg['musicVolumeEq'];
  }
}

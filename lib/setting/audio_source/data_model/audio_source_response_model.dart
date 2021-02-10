import 'package:xj_music/broadcast/base_protocol.dart';

//音源
class AudioSourceResponseModel extends BaseProtocol {
  String resultCode;
  String audioSource;
  String id;

  AudioSourceResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    audioSource = arg['audioSource'].toString();
    id = arg['id'].toString();
  }
}

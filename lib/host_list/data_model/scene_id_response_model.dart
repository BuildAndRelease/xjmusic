import 'package:xj_music/broadcast/base_protocol.dart';

//场景Id响应模型
class SceneIdResponseModel extends BaseProtocol {
  String resultCode;
  String sceneId;

  SceneIdResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    sceneId = arg['sceneId'].toString();
  }
}

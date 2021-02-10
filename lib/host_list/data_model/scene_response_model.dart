import 'package:xj_music/broadcast/base_protocol.dart';

//场景响应模型
class SceneResponseModel extends BaseProtocol {
  String resultCode;
  String sceneId;
  String sceneName;

  SceneResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    sceneId = arg['sceneId'].toString();
    sceneName = arg['sceneName'].toString();
  }
}

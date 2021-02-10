import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.10执行场景的通知
class StartExecuteSceneNotify extends BaseProtocol {
  String sceneId;
  String sceneName;
  StartExecuteSceneNotify(Map json) : super(json) {
    sceneId = arg["sceneId"].toString();
    sceneName = arg["sceneName"].toString();
  }
}

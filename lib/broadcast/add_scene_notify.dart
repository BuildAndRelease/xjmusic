import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.4新建场景通知
class AddSceneNotify extends BaseProtocol {
  String sceneId;
  String sceneName;
  AddSceneNotify(Map json) : super(json) {
    sceneId = arg["sceneId"].toString();
    sceneName = arg["sceneName"].toString();
  }
}

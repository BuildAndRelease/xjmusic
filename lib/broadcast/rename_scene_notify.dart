import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.8修改场景名通知
class RenameSceneNotify extends BaseProtocol {
  String sceneId;
  String sceneName;
  RenameSceneNotify(Map json) : super(json) {
    sceneId = arg["sceneId"].toString();
    sceneName = arg["sceneName"].toString();
  }
}

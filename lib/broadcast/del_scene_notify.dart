import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.6删除场景通知
class DelSceneNotify extends BaseProtocol {
  String sceneId;
  DelSceneNotify(Map json) : super(json) {
    sceneId = arg["sceneId"].toString();
  }
}

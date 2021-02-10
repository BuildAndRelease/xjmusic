import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.12设置场景动作列表的通知
class UpdateSceneActionLisNotify extends BaseProtocol {
  String sceneId;
  UpdateSceneActionLisNotify(Map json) : super(json) {
    sceneId = arg["sceneId"].toString();
  }
}

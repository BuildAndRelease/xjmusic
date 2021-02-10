import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.13获取指定的场景的场景动作列表
class GetSceneActionListResponseModel extends BaseProtocol {
  String resultCode;
  String sceneId;
  String sceneName;
  List list;

  GetSceneActionListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    sceneId = arg['sceneId'].toString();
    sceneName = arg['sceneName'].toString();
    list = arg['list'];
  }

  get listCount => list.length;

  RoomSceneAction listAtIndex(int index) {
    return RoomSceneAction.fromJson(list[index]);
  }
}

class RoomSceneAction {
  String roomId;
  List actionList;

  RoomSceneAction(this.roomId, this.actionList);

  RoomSceneAction.fromJson(Map json) {
    roomId = json['roomId'].toString();
    actionList = json['actionList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['actionList'] = this.actionList;
    return data;
  }
}

import 'package:xj_music/broadcast/base_protocol.dart';

//4.21.1获取场景列表
class GetSceneListResponseModel extends BaseProtocol {
  String resultCode;
  List sceneList;

  GetSceneListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    sceneList = arg['sceneList'];
  }

  get sceneListCount => sceneList.length;

  MusicScene sceneListAtIndex(int index) {
    MusicScene musicScene = MusicScene.fromJson(sceneList[index]);
    return musicScene;
  }
}

class MusicScene {
  String sceneId;
  String sceneName;

  MusicScene({this.sceneId, this.sceneName});

  MusicScene.fromJson(Map json) {
    sceneId = json['sceneId'].toString();
    sceneName = json['sceneName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sceneId'] = this.sceneId;
    data['sceneName'] = this.sceneName;
    return data;
  }
}

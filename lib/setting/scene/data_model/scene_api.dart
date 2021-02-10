import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'get_scene_action_list_response_model.dart';
import 'get_scene_list_response_model.dart';
import 'scene_id_response_model.dart';
import 'scene_response_model.dart';

class SceneApi {
  //4.21.1获取场景列表
  static getSceneList(
      {void Function(GetSceneListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetSceneList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSceneListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.2新建场景
  static addScene(String sceneName,
      {void Function(SceneResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneName": sceneName};
    await DataCenter.instance.sendMsgToDevice("AddScene", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.3新建场景带参数（动作）
  static addSceneWithAction(String sceneName, List list,
      {void Function(SceneResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneName": sceneName, "list": list};
    await DataCenter.instance.sendMsgToDevice("AddSceneWithAction", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.5删除场景
  static delScene(String sceneId,
      {void Function(SceneIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneId": sceneId};
    await DataCenter.instance.sendMsgToDevice("DelScene", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.7修改场景名
  static renameScene(String sceneId, String sceneName,
      {void Function(SceneResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneId": sceneId, "sceneName": sceneName};
    await DataCenter.instance.sendMsgToDevice("RenameScene", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.9执行场景
  static executeScene(String sceneId,
      {void Function(SceneIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneId": sceneId};
    await DataCenter.instance.sendMsgToDevice("ExecuteScene", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.11设置场景动作列表
  static setActionListToScene(String sceneId, List list,
      {void Function(SceneIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneId": sceneId, "list": list};
    await DataCenter.instance.sendMsgToDevice("SetActionListToScene", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SceneIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.21.13获取指定的场景的场景动作列表
  static getSceneActionList(String sceneId,
      {void Function(GetSceneActionListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sceneId": sceneId};
    await DataCenter.instance.sendMsgToDevice("GetSceneActionList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSceneActionListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

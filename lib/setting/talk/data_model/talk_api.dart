import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/add_talk_response_model.dart';
import 'del_talk_response_model.dart';
import 'get_talk_list_response_model.dart';
import 'get_talk_room_list_response_model.dart';
import 'rename_talk_response_model.dart';
import 'talk_room_list_response_model.dart';
import 'talk_stat_response_model.dart';

class TalkApi {
  //4.24.4删除对讲组
  static delTalk(String talkId,
      {void Function(DelTalkResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId};
    await DataCenter.instance.sendMsgToDevice("DelTalk", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DelTalkResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.6重命名对讲组
  static renameTalk(String talkId, String talkName,
      {void Function(RenameTalkResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId, "talkName": talkName};
    await DataCenter.instance.sendMsgToDevice("RenameTalk", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(RenameTalkResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.8获取指定对讲组房间成员
  static getTalkRoomList(String talkId,
      {void Function(GetTalkRoomListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId};
    await DataCenter.instance.sendMsgToDevice("GetTalkRoomList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetTalkRoomListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.9将指定房间加入指定对讲组
  static addTalkRoom(String talkId, List talkRoom,
      {void Function(TalkRoomListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId, "talkRoom": talkRoom};
    await DataCenter.instance.sendMsgToDevice("AddTalkRoom", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TalkRoomListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.11将指定房间从指定对讲组中删除
  static delTalkRoom(String talkId, List talkRoom,
      {void Function(TalkRoomListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId, "talkRoom": talkRoom};
    await DataCenter.instance.sendMsgToDevice("DelTalkRoom", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TalkRoomListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.13开启/关闭对讲组
  static setTalkStat(String talkId, String talkStat,
      {void Function(TalkStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId, "talkStat": talkStat};
    await DataCenter.instance.sendMsgToDevice("SetTalkStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TalkStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.15获取对讲组开启/关闭状态
  static getTalkStat(String talkId,
      {void Function(TalkStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkId": talkId};
    await DataCenter.instance.sendMsgToDevice("GetTalkStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TalkStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.1获取对讲组列表
  static getTalkList(
      {void Function(GetTalkListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetTalkList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetTalkListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.24.2新建对讲组
  static addTalk(String talkName, List talkRoom,
      {void Function(AddTalkResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"talkName": talkName, "talkRoom": talkRoom};
    await DataCenter.instance.sendMsgToDevice("AddTalk", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(AddTalkResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

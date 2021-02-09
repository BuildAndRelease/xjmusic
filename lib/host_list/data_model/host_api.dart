import 'dart:convert' as convert;
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/host_list/data_model/set_dev_info_response_model.dart';

import 'get_dev_info_response_model.dart';
import 'get_playing_info_response_model.dart';
import 'get_room_stat_info_response_model.dart';

// 设备控制接口
class HostApi {
  static getHostRoomList(String hostId,
      {String ipAddress,
      void Function(GetHostRoomListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"hostId": hostId};
    await DataCenter.instance.sendMsgToDevice("GetHostRoomList", arg,
        recvId: hostId, ipAddress: ipAddress, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetHostRoomListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  static setDevStat(String hostId, String devStat,
      {String ipAddress,
      void Function(SetDevStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"devStat": devStat};
    await DataCenter.instance.sendMsgToDevice("SetDevStat", arg,
        recvId: hostId, ipAddress: ipAddress, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SetDevStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

//4.4.1获取房间当前信息
  static getPlayingInfo(
      {void Function(GetPlayingInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetPlayingInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetPlayingInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

//4.4.3获取当前房间的基本状态信息（用于一次性获取较多的信息）
  static getRoomStatInfo(
      {void Function(GetRoomStatInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetRoomStatInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetRoomStatInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

//4.5.1获取设备信息
  static getDevInfo(
      {void Function(GetDevInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetDevInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDevInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

//4.5.2设置设备信息[用于更改房间名称]
  static setDevInfo(String devName,
      {void Function(SetDevInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"devName": devName};
    await DataCenter.instance.sendMsgToDevice("SetDevInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SetDevInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

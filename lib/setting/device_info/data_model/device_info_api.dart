import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'get_dev_info_response_model.dart';
import 'get_dev_stat_response_model.dart';
import 'get_system_update_response_model.dart';
import 'get_system_usb_stat_response_model.dart';
import 'set_dev_info_response_model.dart';
import 'set_room_serial_id_list_response_model.dart';
import 'start_system_update_response_model.dart';

class DeviceInfoApi {
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

//4.6.1获取设备开关机状态
  static getDevStat(
      {void Function(GetDevStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetDevStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDevStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.22.1Usb/SD热拔插设备拔插状态获取
  static getSystemUsbStat(
      {void Function(GetSystemUsbStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetSystemUsbStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSystemUsbStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.26.3设置房间串口ID[列表形式]
  static setRoomSerialIdList(List list,
      {void Function(SetRoomSerialIdListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"list": list};
    await DataCenter.instance.sendMsgToDevice("SetRoomSerialIdList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SetRoomSerialIdListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.34.1获取系统升级信息
  static getSystemUpdate(String updateType,
      {void Function(GetSystemUpdateResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"updateType": updateType};
    await DataCenter.instance.sendMsgToDevice("GetSystemUpdate", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSystemUpdateResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.34.2开始升级
  static startSystemUpdate(String updateType, String updateVersion,
      {void Function(StartSystemUpdateResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"updateType": updateType, "updateVersion": updateVersion};
    await DataCenter.instance.sendMsgToDevice("StartSystemUpdate", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(StartSystemUpdateResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

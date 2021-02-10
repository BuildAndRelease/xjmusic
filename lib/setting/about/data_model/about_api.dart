import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'sys_date_response_model.dart';
import 'sys_time_response_model.dart';
import 'system_server_name_response_model.dart';

class AboutApi {
  //4.13.1获取当前系统时间
  static getSysTime(
      {void Function(SysTimeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetSysTime", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SysTimeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.13.2设置当前系统时间
  static setSysTime(String time,
      {void Function(SysTimeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"time": time};
    await DataCenter.instance.sendMsgToDevice("SetSysTime", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SysTimeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.14.1获取系统日期
  static getSysDate(
      {void Function(SysDateResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetSysDate", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SysDateResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.14.2修改系统日期
  static setSysDate(String date,
      {void Function(SysDateResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"date": date};
    await DataCenter.instance.sendMsgToDevice("SetSysDate", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SysDateResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.27.1获取系统主机名称
  static getSystemServerName(
      {void Function(SystemServerNameResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetSystemServerName", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SystemServerNameResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.27.2设置系统主机名称
  static setSystemServerName(String serverName,
      {void Function(SystemServerNameResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"serverName": serverName};
    await DataCenter.instance.sendMsgToDevice("SetSystemServerName", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SystemServerNameResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

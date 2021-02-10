import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'get_delay_close_timer_response_model.dart';
import 'get_timer_list_response_model.dart';
import 'modify_delay_close_timer_response_model.dart';
import 'timer_id_response_model.dart';
import 'timer_response_model.dart';

class AlarmApi {
  //4.25.1获取定时器列表
  static getTimerList(
      {void Function(GetTimerListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetTimerList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetTimerListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.2添加定时器
  static addTimer(String timerName, String timerEnable, String circleDay,
      String actionName, String specialDate, String preSetTime, Map media,
      {void Function(TimerResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "timerName": timerName,
      "timerEnable": timerEnable,
      "circleDay": circleDay,
      "actionName": actionName,
      "specialDate": specialDate,
      "preSetTime": preSetTime,
      "media": media
    };
    await DataCenter.instance.sendMsgToDevice("AddTimer", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TimerResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.4删除定时器
  static delTimer(String timerId,
      {void Function(TimerIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"timerId": timerId};
    await DataCenter.instance.sendMsgToDevice("DelTimer", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TimerIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.5修改定时器
  static modifyTimer(
      String timerId,
      String timerName,
      String timerEnable,
      String circleDay,
      String actionName,
      String specialDate,
      String preSetTime,
      Map media,
      {void Function(TimerResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "timerId": timerId,
      "timerName": timerName,
      "timerEnable": timerEnable,
      "circleDay": circleDay,
      "actionName": actionName,
      "specialDate": specialDate,
      "preSetTime": preSetTime,
      "media": media
    };
    await DataCenter.instance.sendMsgToDevice("ModifyTimer", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TimerResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.6关闭闹钟
  static closeClockPlay(String timerId,
      {void Function(TimerIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"timerId": timerId};
    await DataCenter.instance.sendMsgToDevice("CloseClockPlay", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TimerIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.9获取延时关机定时器
  static getDelayCloseTimer(
      {void Function(GetDelayCloseTimerResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetDelayCloseTimer", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDelayCloseTimerResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.25.10修改延时关机定时器
  static modifyDelayCloseTimer(String delayCloseAfterTimes,
      {void Function(ModifyDelayCloseTimerResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"delayCloseAfterTimes": delayCloseAfterTimes};
    await DataCenter.instance.sendMsgToDevice("ModifyDelayCloseTimer", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ModifyDelayCloseTimerResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

import 'dart:convert' as convert;
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/get_current_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/play_cmd_response_model.dart';
import 'package:xj_music/host_list/data_model/play_current_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/play_list_mode_response_model.dart';
import 'package:xj_music/host_list/data_model/play_mode_response_model.dart';
import 'package:xj_music/host_list/data_model/play_music_response_model.dart';
import 'package:xj_music/host_list/data_model/play_stat_response_model.dart';
import 'package:xj_music/host_list/data_model/play_time_response_model%20copy.dart';
import 'package:xj_music/host_list/data_model/result_code_response_model.dart';
import 'package:xj_music/host_list/data_model/sys_date_response_model.dart';
import 'package:xj_music/host_list/data_model/sys_time_response_model.dart';
import 'package:xj_music/host_list/data_model/treble_response_model.dart';
import 'package:xj_music/host_list/data_model/volume_response_model.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/host_list/data_model/set_all_dev_stat_response_model.dart';
import 'package:xj_music/host_list/data_model/set_dev_info_response_model.dart';

import 'audio_source_response_model.dart';
import 'aux_response_model.dart';
import 'bass_response_model.dart';
import 'del_history_play_list_response_model.dart';
import 'get_dev_info_response_model.dart';
import 'get_dev_stat_response_model.dart';
import 'eq_response_model.dart';
import 'get_history_play_list_response_model.dart';
import 'get_playing_info_response_model.dart';
import 'get_room_stat_info_response_model.dart';
import 'mute_response_model.dart';

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

//4.6.2开关机
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

  //4.6.4房间全开/全关
  static setAllDevStat(String devStat,
      {void Function(SetAllDevStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"devStat": devStat};
    await DataCenter.instance.sendMsgToDevice("SetAllDevStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SetAllDevStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.7.1获取音量
  static getVolume(
      {void Function(VolumeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetVolume", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(VolumeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.7.2设置音量
  static setVolume(String volume,
      {void Function(VolumeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"volume": volume};
    await DataCenter.instance.sendMsgToDevice("SetVolume", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(VolumeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.7.3音量加
  static addVolume(String volume,
      {void Function(VolumeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"volume": volume};
    await DataCenter.instance.sendMsgToDevice("AddVolume", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(VolumeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.7.4音量减
  static subVolume(String volume,
      {void Function(VolumeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"volume": volume};
    await DataCenter.instance.sendMsgToDevice("SubVolume", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(VolumeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.8.1获取音效
  static getEq(
      {void Function(EqResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetEq", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(EqResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.8.2设置音效
  static setEq(String eq,
      {void Function(EqResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"eq": eq};
    await DataCenter.instance.sendMsgToDevice("SetEq", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(EqResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.9.1获取低音
  static getBass(
      {void Function(BassResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetBass", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(BassResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.9.2设置低音
  static setBass(String bass,
      {void Function(BassResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"bass": bass};
    await DataCenter.instance.sendMsgToDevice("SetBass", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(BassResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.10.1获取高音
  static getTreble(
      {void Function(TrebleResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetTreble", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TrebleResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.10.2设置高音
  static setTreble(String treb,
      {void Function(TrebleResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"treb": treb};
    await DataCenter.instance.sendMsgToDevice("SetTreble", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(TrebleResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.10.1获取高音
  static getMute(
      {void Function(MuteResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetMute", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MuteResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.10.2设置高音
  static setMute(String muteStat,
      {void Function(MuteResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"muteStat": muteStat};
    await DataCenter.instance.sendMsgToDevice("SetMute", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MuteResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.12.1获取播放模式
  static getPlayMode(
      {void Function(PlayModeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetPlayMode", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayModeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.12.2设置播放模式
  static setPlayMode(String playMode,
      {void Function(PlayModeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playMode": playMode};
    await DataCenter.instance.sendMsgToDevice("SetPlayMode", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayModeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

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

  //4.15.1播放本地音乐
  static playLocalMusic(Map media,
      {void Function(PlayMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayLocalMusic", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.2播放云音乐
  static playCloudMusic(Map media,
      {void Function(PlayMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudMusic", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.3播放云音乐(列表形式)
  static playCloudMusicList(List mediaList, Map media,
      {void Function(PlayMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaList": mediaList, "media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.4播放云语言节目
  static playCloudStory(Map media,
      {void Function(PlayMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudStory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.5播放网络电台
  static playCloudNetFm(Map media,
      {void Function(PlayMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudNetFm", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.6切换到Aux
  static SwitchToAux(String auxId,
      {void Function(AuxResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"auxId": auxId};
    await DataCenter.instance.sendMsgToDevice("SwitchToAux", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(AuxResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.7媒体播放、暂停、上一曲、下一曲控制
  static playCmd(String playCmd,
      {void Function(PlayCmdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playCmd": playCmd};
    await DataCenter.instance.sendMsgToDevice("PlayCmd", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayCmdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.8切换音源
  static setAudioSource(String audioSource, String id,
      {void Function(AudioSourceResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"audioSource": audioSource, "id": id};
    await DataCenter.instance.sendMsgToDevice("SetAudioSource", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(AudioSourceResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.9获取当前播放状态
  static GetPlayStat(
      {void Function(PlayStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetPlayStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.16.1获取当前播放时间
  static getPlayTime(
      {void Function(PlayTimeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetPlayTime", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayTimeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.16.2设置当前播放时间
  static setPlayTime(String playTime,
      {void Function(PlayTimeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playTime": playTime};
    await DataCenter.instance.sendMsgToDevice("SetPlayTime", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayTimeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.1播放当前播放列表
  static playCurrentPlayList(Map media,
      {void Function(PlayCurrentPlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCurrentPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayCurrentPlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.2获取当前播放列表
  static getCurrentPlayList(String pageNum, String pageSize, String id,
      {void Function(GetCurrentPlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageNum": pageNum, "pageSize": pageSize, "id": id};
    await DataCenter.instance.sendMsgToDevice("GetCurrentPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetCurrentPlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.3设置当前播放列表的升序模式
  static setPlayListMode(String isAsc,
      {void Function(PlayListModeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"isAsc": isAsc};
    await DataCenter.instance.sendMsgToDevice("SetPlayListMode", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayListModeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.4获取当前播放列表的升序模式
  static getPlayListMode(
      {void Function(PlayListModeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetPlayListMode", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayListModeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.5从当前播放列表中删除媒体(批量操作)
  static delMediaListFromPlayMediaList(List mediaList,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaList": mediaList};
    await DataCenter.instance.sendMsgToDevice(
        "DelMediaListFromPlayMediaList", arg, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ResultCodeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.6从当前播放列表中删除媒体(单个操作)
  static delMediaFromPlayMediaList(Map media,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("DelMediaFromPlayMediaList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ResultCodeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.7清空当前播放列表
  static clearPlayMediaList(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("ClearPlayMediaList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ResultCodeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.8添加云音乐列表（目前仅支持云音乐）
  static addToCloudMusicList(List mediaList,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaList": mediaList};
    await DataCenter.instance.sendMsgToDevice("AddToCloudMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ResultCodeResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.2获取当前播放列表
  static getHistoryPlayList(String pageNum, String pageSize, String mediaSrc,
      {void Function(GetHistoryPlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "pageNum": pageNum,
      "pageSize": pageSize,
      "mediaSrc": mediaSrc
    };
    await DataCenter.instance.sendMsgToDevice("GetHistoryPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetHistoryPlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.17.10删除历史播放列表
  static delHistoryPlayList(String mediaSrc, List mediaList,
      {void Function(DelHistoryPlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaSrc": mediaSrc, "mediaList": mediaList};
    await DataCenter.instance.sendMsgToDevice("DelHistoryPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DelHistoryPlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

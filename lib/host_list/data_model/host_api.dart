import 'dart:convert' as convert;
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/get_current_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/get_favorite_set_response_model.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_anchor_category_list_response_model.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_rank_album_list_response_model.dart';
import 'package:xj_music/host_list/data_model/party_stat_response_model.dart';
import 'package:xj_music/host_list/data_model/play_cmd_response_model.dart';
import 'package:xj_music/host_list/data_model/play_list_mode_response_model.dart';
import 'package:xj_music/host_list/data_model/play_mode_response_model.dart';
import 'package:xj_music/host_list/data_model/play_result_response_model.dart';
import 'package:xj_music/host_list/data_model/play_stat_response_model.dart';
import 'package:xj_music/host_list/data_model/play_time_response_model%20copy.dart';
import 'package:xj_music/host_list/data_model/rename_favorite_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/result_code_response_model.dart';
import 'package:xj_music/host_list/data_model/room_serial_id_response_model.dart';
import 'package:xj_music/host_list/data_model/search_album_response_model.dart';
import 'package:xj_music/host_list/data_model/search_local_music_response_model.dart';
import 'package:xj_music/host_list/data_model/search_lyric_response_model.dart';
import 'package:xj_music/host_list/data_model/search_pre_view_response_model.dart';
import 'package:xj_music/host_list/data_model/search_song_response_model.dart';
import 'package:xj_music/host_list/data_model/set_default_download_path_response_model.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/story_telling_response_model.dart';
import 'package:xj_music/host_list/data_model/treble_response_model.dart';
import 'package:xj_music/host_list/data_model/volume_response_model.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/host_list/data_model/set_all_dev_stat_response_model.dart';

import 'download_path_list_response_model.dart';
import 'download_music_list_response_model.dart';
import 'downloaded_music_list_response_model.dart';
import 'get_album_response_model.dart';
import 'get_album_song_response_model.dart';
import 'get_category_diss_response_model.dart';
import 'get_category_response_model.dart';
import 'get_category_song_response_model.dart';
import 'get_diss_category_response_model.dart';
import 'get_diss_response_model.dart';
import 'get_diss_song_response_model.dart';
import 'get_download_path_list_response_model.dart';
import 'get_local_directory_response_model.dart';
import 'get_new_song_response_model.dart';
import 'get_radio_response_model.dart';
import 'get_radio_song_response_model.dart';
import 'get_recommend_response_model.dart';
import 'get_singer_album_response_model.dart';
import 'get_singer_response_model.dart';
import 'get_singer_song_response_model.dart';
import 'get_storytelling_album_info_model.dart';
import 'get_storytelling_anchor_list_response_model.dart';
import 'get_storytelling_category_response_model.dart';
import 'get_storytelling_rank_list_response_model.dart';
import 'get_storytelling_response_model .dart';
import 'get_top_list_response_model.dart';
import 'get_top_list_song_response_model.dart';
import 'music_volume_eq_response_model.dart';
import 'folder_response_model.dart';
import 'add_favorite_play_list_response_model.dart';
import 'aux_response_model.dart';
import 'bass_response_model.dart';
import 'contain_response_model.dart';
import 'folder_id_response_model.dart';
import 'del_favorite_media_response_model.dart';
import 'del_favorite_play_list_response_model.dart';
import 'get_album_set_favorite_list_response_model.dart';
import 'get_favorite_media_response_model.dart';
import 'media_src_response_model.dart';
import 'eq_response_model.dart';
import 'get_favorite_play_list_response_model.dart';
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

  //4.15.1播放本地音乐
  static playLocalMusic(Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayLocalMusic", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.2播放云音乐
  static playCloudMusic(Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudMusic", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.3播放云音乐(列表形式)
  static playCloudMusicList(List mediaList, Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaList": mediaList, "playMedia": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.4播放云语言节目
  static playCloudStory(Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudStory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.5播放网络电台
  static playCloudNetFm(Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCloudNetFm", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.15.6切换到Aux
  static switchToAux(String auxId,
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

  //4.15.9获取当前播放状态
  static getPlayStat(
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
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"media": media};
    await DataCenter.instance.sendMsgToDevice("PlayCurrentPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
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
      {void Function(MediaSrcResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaSrc": mediaSrc, "mediaList": mediaList};
    await DataCenter.instance.sendMsgToDevice("DelHistoryPlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MediaSrcResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.1获取自建歌单列表
  static getFavoritePlayList(
      {void Function(GetFavoritePlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetFavoritePlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetFavoritePlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.2新建自建歌单
  static addFavoritePlayList(String playListName,
      {void Function(AddFavoritePlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playListName": playListName};
    await DataCenter.instance.sendMsgToDevice("AddFavoritePlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(AddFavoritePlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.4删除自建歌单
  static delFavoritePlayList(String playListId,
      {void Function(DelFavoritePlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playListId": playListId};
    await DataCenter.instance.sendMsgToDevice("DelFavoritePlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DelFavoritePlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.6修改自建歌单名
  static renameFavoritePlayList(String playListId, String playListName,
      {void Function(RenameFavoritePlayListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"playListId": playListId, "playListName": playListName};
    await DataCenter.instance.sendMsgToDevice("RenameFavoritePlayList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(RenameFavoritePlayListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.8将歌曲收藏到指定的自建歌单
  static addFavoriteMedia(String playListId, String mediaSrc, List mediaList,
      {void Function(MediaSrcResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "playListId": playListId,
      "mediaSrc": mediaSrc,
      "mediaList": mediaList
    };
    await DataCenter.instance.sendMsgToDevice("AddFavoriteMedia", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MediaSrcResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.10将歌曲从指定的自建歌单中取消收藏
  static delFavoriteMedia(String playListId, String mediaSrc, List mediaList,
      {void Function(DelFavoriteMediaResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "playListId": playListId,
      "mediaSrc": mediaSrc,
      "mediaList": mediaList
    };
    await DataCenter.instance.sendMsgToDevice("DelFavoriteMedia", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DelFavoriteMediaResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.12获取指定的自建歌单的歌曲列表
  static getFavoriteMedia(
      String playListId, String beginIndex, String num, String mediaSrc,
      {void Function(GetFavoriteMediaResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "playListId": playListId,
      "beginIndex": beginIndex,
      "num": num,
      "mediaSrc": mediaSrc
    };
    await DataCenter.instance.sendMsgToDevice("GetFavoriteMedia", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetFavoriteMediaResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.13判断歌曲是否已收藏
  static containFavoriteMedia(String playListId, String mediaSrc, Map media,
      {void Function(ContainResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "playListId": playListId,
      "mediaSrc": mediaSrc,
      "media": media
    };
    await DataCenter.instance.sendMsgToDevice("ContainFavoriteMedia", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ContainResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.19.14播放我的自建歌单中的歌曲
  static playFavoriteMedia(String playListId, String mediaSrc, Map media,
      {void Function(PlayResultResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "playListId": playListId,
      "mediaSrc": mediaSrc,
      "media": media
    };
    await DataCenter.instance.sendMsgToDevice("PlayFavoriteMedia", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PlayResultResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.1获取收藏歌单列表
  static getAlbumSetFavoriteList(
      {void Function(GetAlbumSetFavoriteListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetAlbumSetFavoriteList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetAlbumSetFavoriteListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.2新建收藏歌单
  static addAlbumSetFavoriteList(String folderName,
      {void Function(FolderResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderName": folderName};
    await DataCenter.instance.sendMsgToDevice("AddAlbumSetFavoriteList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.4删除收藏歌单
  static delAlbumSetFavoriteList(String folderId,
      {void Function(FolderIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId};
    await DataCenter.instance.sendMsgToDevice("DelAlbumSetFavoriteList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.6修改收藏歌单的名称
  static renameAlbumSetFavorite(String folderId, String folderName,
      {void Function(FolderResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId, "folderName": folderName};
    await DataCenter.instance.sendMsgToDevice("RenameAlbumSetFavorite", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.8将歌单收藏到指定的收藏歌单
  static addSetToAlbumSetFavorite(String folderId, Map albumSet,
      {void Function(FolderResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId, "albumSet": albumSet};
    await DataCenter.instance.sendMsgToDevice("AddSetToAlbumSetFavorite", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.9将歌单收藏到指定的收藏歌单[批量]
  static addSetListToAlbumSetFavorite(String folderId, List list,
      {void Function(FolderResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId, "list": list};
    await DataCenter.instance.sendMsgToDevice(
        "AddSetListToAlbumSetFavorite", arg, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.11将歌单从指定的收藏歌单中取消收藏
  static delFavoriteSet(String folderId, List list,
      {void Function(FolderIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId, "list": list};
    await DataCenter.instance.sendMsgToDevice("DelFavoriteSet", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(FolderIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.13获取指定的专辑收藏夹中专辑列表
  static getFavoriteSet(String folderId,
      {String albumTypeName,
      void Function(GetFavoriteSetResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId};
    if (albumTypeName?.isNotEmpty ?? false)
      arg["albumTypeName"] = albumTypeName;
    await DataCenter.instance.sendMsgToDevice("GetFavoriteSet", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetFavoriteSetResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.20.14判断专辑是否已收藏
  static containFavoriteSet(String folderId, Map albumSet,
      {void Function(ContainResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"folderId": folderId, "albumSet": albumSet};
    await DataCenter.instance.sendMsgToDevice("ContainFavoriteSet", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ContainResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.23.1打开/关闭party组
  static setUniquePartyStat(String partyStat, String hostId,
      {void Function(PartyStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"partyStat": partyStat, "hostId": hostId};
    await DataCenter.instance.sendMsgToDevice("SetUniquePartyStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PartyStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.23.3获取party组状态
  static getUniquePartyStat(
      {void Function(PartyStatResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetUniquePartyStat", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(PartyStatResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.26.1获取房间串口ID
  static getRoomSerialId(
      {void Function(RoomSerialIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetRoomSerialId", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(RoomSerialIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.26.2设置房间串口ID
  static setRoomSerialId(String serialId,
      {void Function(RoomSerialIdResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"serialId": serialId};
    await DataCenter.instance.sendMsgToDevice("SetRoomSerialId", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(RoomSerialIdResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.1云资源下载
  static downloadMusicList(String downloadPath, List mediaList,
      {void Function(DownloadMusicListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"downloadPath": downloadPath, "mediaList": mediaList};
    await DataCenter.instance.sendMsgToDevice("DownloadMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DownloadMusicListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.3获取资源下载下载路径
  static getDownloadPathList(
      {void Function(GetDownloadPathListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetDownloadPathList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDownloadPathListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.4添加资源下载路径
  static addDownloadPath(List downloadPathList,
      {void Function(DownloadPathListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"downloadPathList": downloadPathList};
    await DataCenter.instance.sendMsgToDevice("AddDownloadPath", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DownloadPathListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.5删除资源下载路径
  static delDownloadPath(List downloadPathList,
      {void Function(DownloadPathListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"downloadPathList": downloadPathList};
    await DataCenter.instance.sendMsgToDevice("DelDownloadPath", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DownloadPathListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.6设置默认下载
  static setDefaultDownloadPath(String defaultPath,
      {void Function(SetDefaultDownloadPathResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"defaultPath": defaultPath};
    await DataCenter.instance.sendMsgToDevice("SetDefaultDownloadPath", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SetDefaultDownloadPathResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.8获取已下载的列表
  static getDownloadedMusicList(String mediaSrc,
      {void Function(DownloadedMusicListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaSrc": mediaSrc};
    await DataCenter.instance.sendMsgToDevice("GetDownloadedMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DownloadedMusicListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.9获取正在下载的列表
  static getDownloadingMusicList(String mediaSrc,
      {void Function(DownloadedMusicListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mediaSrc": mediaSrc};
    await DataCenter.instance.sendMsgToDevice("GetDownloadingMusicList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(DownloadedMusicListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.29.10操作下载的列表
  static operatoDownload(String cmd, List medialList,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"cmd": cmd, "medialList": medialList};
    await DataCenter.instance.sendMsgToDevice("OperatoDownload", arg,
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

  //4.30清空所有配置文件
  static clearAllRoomSetting(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("ClearAllRoomSetting", arg,
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

  //4.31.1获取音效均衡器
  static getMusicVolumeEq(
      {void Function(MusicVolumeEqResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetMusicVolumeEq", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MusicVolumeEqResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.31.2设置音效均衡器
  static setMusicVolumeEq(String eqType, Map musicVolumeEq,
      {void Function(MusicVolumeEqResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"eqType": eqType, "musicVolumeEq": musicVolumeEq};
    await DataCenter.instance.sendMsgToDevice("SetMusicVolumeEq", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(MusicVolumeEqResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.32系统重启
  static restartSystem(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("RestartSystem", arg,
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

  //4.33重新搜索房间(用于重新获取房间列表)
  static researchRoom(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("ResearchRoom", arg,
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

  //5.1.1获取指定目录的信息
  static getLocalDirectory(
      String directoryMid, String beginIndex, String num, String ignoreEmpty,
      {void Function(GetLocalDirectoryResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "directoryMid": directoryMid,
      "beginIndex": beginIndex,
      "num": num,
      "ignoreEmpty": ignoreEmpty
    };
    await DataCenter.instance.sendMsgToDevice("GetLocalDirectory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetLocalDirectoryResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.1.2搜索本地歌曲
  static searchLocalMusic(String keywords, String beginIndex, String num,
      {void Function(SearchLocalMusicResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"keywords": keywords, "beginIndex": beginIndex, "num": num};
    await DataCenter.instance.sendMsgToDevice("SearchLocalMusic", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SearchLocalMusicResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.1.3新建目录
  static mkLocalDiskDir(String dest,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"dest": dest};
    await DataCenter.instance.sendMsgToDevice("MkLocalDiskDir", arg,
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

  //5.1.4重命名目录
  static moveLocalDiskDir(String source, String dest,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"source": source, "dest": dest};
    await DataCenter.instance.sendMsgToDevice("MoveLocalDiskDir", arg,
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

  //5.1.5删除目录
  static rmLocalDiskDir(List sourceList,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sourceList": sourceList};
    await DataCenter.instance.sendMsgToDevice("RmLocalDiskDir", arg,
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

  //5.1.6删除文件
  static rmLocalDiskFile(List sourceList,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"sourceList": sourceList};
    await DataCenter.instance.sendMsgToDevice("RmLocalDiskFile", arg,
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

  //5.1.6删除文件
  static moveLocalDiskFile(String source,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"source": source};
    await DataCenter.instance.sendMsgToDevice("MoveLocalDiskFile", arg,
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

  //5.2.1获取歌手
  static getSinger(String category, String index, String pageNo,
      {void Function(GetSingerResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"category": category, "index": index, "pageNo": pageNo};
    await DataCenter.instance.sendMsgToDevice("GetSinger", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSingerResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.2获取歌手的歌曲
  static getSingerSong(
      String begin, String order, String singerMid, String size,
      {void Function(GetSingerSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "begin": begin,
      "order": order,
      "singerMid": singerMid,
      "size": size
    };
    await DataCenter.instance.sendMsgToDevice("GetSingerSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSingerSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.3获取歌手的专辑
  static getSingerAlbum(
      String begin, String order, String singerMid, String size,
      {void Function(GetSingerAlbumResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "begin": begin,
      "order": order,
      "singerMid": singerMid,
      "size": size
    };
    await DataCenter.instance.sendMsgToDevice("GetSingerAlbum", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetSingerAlbumResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.5获取排行榜
  static getTopList(
      {void Function(GetTopListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetTopList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetTopListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.6获取排行榜的歌曲
  static getTopListSong(String topListDate, String topListId,
      {void Function(GetTopListSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"topListDate": topListDate, "topListId": topListId};
    await DataCenter.instance.sendMsgToDevice("GetTopListSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetTopListSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.7获取分类
  static getCategory(
      {void Function(GetCategoryResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetCategory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetCategoryResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.8获取分类下的歌曲
  static getCategorySong(
      String categoryId, String pageNum, String perpage, String sort,
      {void Function(GetCategorySongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pageNum": pageNum,
      "perpage": perpage,
      "sort": sort
    };
    await DataCenter.instance.sendMsgToDevice("GetCategorySong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetCategorySongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.9获取分类下的歌单
  static getCategoryDiss(
      String categoryId, String pageNum, String perpage, String sort,
      {void Function(GetCategoryDissResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pageNum": pageNum,
      "perpage": perpage,
      "sort": sort
    };
    await DataCenter.instance.sendMsgToDevice("GetCategoryDiss", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetCategoryDissResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.10获取分类下的专辑
  static getCategoryAlbum(
      String categoryId, String pageNum, String perpage, String sort,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pageNum": pageNum,
      "perpage": perpage,
      "sort": sort
    };
    await DataCenter.instance.sendMsgToDevice("GetCategoryAlbum", arg,
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

  //5.2.11获取歌单分类
  static getDissCategory(
      {void Function(GetDissCategoryResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetDissCategory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDissCategoryResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.12获取指定歌单分类下的歌单
  static getDiss(String categoryId, String from, String sort, String to,
      {void Function(GetDissResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "from": from,
      "sort": sort,
      "to": to
    };
    await DataCenter.instance.sendMsgToDevice("GetDiss", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDissResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.13获取歌单下的歌曲
  static getDissSong(String dissId,
      {void Function(GetDissSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"dissId": dissId};
    await DataCenter.instance.sendMsgToDevice("GetDissSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetDissSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.14获取歌单的信息
  static getDissInfo(String dissId,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"dissId": dissId};
    await DataCenter.instance.sendMsgToDevice("GetDissInfo", arg,
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

  //5.2.15获取专辑
  static getAlbum(String area, String index, String pageNo, String perpage,
      String sort, String time, String type,
      {void Function(GetAlbumResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "area": area,
      "index": index,
      "pageNo": pageNo,
      "perpage": perpage,
      "sort": sort,
      "time": time,
      "type": type
    };
    await DataCenter.instance.sendMsgToDevice("GetAlbum", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetAlbumResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.16获取专辑下的歌曲
  static getAlbumSong(String albumMid,
      {void Function(GetAlbumSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"albumMid": albumMid};
    await DataCenter.instance.sendMsgToDevice("GetAlbumSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetAlbumSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.17获取电台
  static getRadio(
      {void Function(GetRadioResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetRadio", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetRadioResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.18获取电台歌曲[内部使用]
  static getRadioSong(String radioId,
      {void Function(GetRadioSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"radioId": radioId};
    await DataCenter.instance.sendMsgToDevice("GetRadioSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetRadioSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.19获取新歌速递
  static getNewSong(String area,
      {void Function(GetNewSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"area": area};
    await DataCenter.instance.sendMsgToDevice("GetNewSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetNewSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.20获取热门推荐
  static getRecommend(
      {void Function(GetRecommendResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetRecommend", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetRecommendResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.21搜索提示
  static searchPreView(String searchText,
      {void Function(SearchPreViewResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"searchText ": searchText};
    await DataCenter.instance.sendMsgToDevice("SearchPreView", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SearchPreViewResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.22搜索歌词
  static searchLyric(String pageNo, String searchText,
      {void Function(SearchLyricResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageNo": pageNo, "searchText": searchText};
    await DataCenter.instance.sendMsgToDevice("SearchLyric", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SearchLyricResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.23搜索歌曲
  static searchSong(String pageNo, String searchText,
      {void Function(SearchSongResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageNo": pageNo, "searchText": searchText};
    await DataCenter.instance.sendMsgToDevice("SearchSong", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SearchSongResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.24搜索专辑
  static searchAlbum(String pageNo, String searchText,
      {void Function(SearchAlbumResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageNo": pageNo, "searchText": searchText};
    await DataCenter.instance.sendMsgToDevice("SearchAlbum", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(SearchAlbumResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.2.25获取歌曲的URL[内部]
  static getSongPlayUrl(String mid,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"mid ": mid};
    await DataCenter.instance.sendMsgToDevice("GetSongPlayUrl", arg,
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

  //5.2.26获取歌曲的歌词URL
  static getSongLyric(String songMid,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"songMid ": songMid};
    await DataCenter.instance.sendMsgToDevice("GetSongLyric", arg,
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

  //5.3.1获取语言节目的分类
  static getStorytellingCategory(
      {void Function(GetStorytellingCategoryResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetStorytellingCategory", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingCategoryResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.2获取分类下的语言节目
  static getStorytelling(String categoryId, String pagenum, String perpage,
      {void Function(GetStorytellingResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pagenum": pagenum,
      "perpage": perpage
    };
    await DataCenter.instance.sendMsgToDevice("GetStorytelling", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.3获取语言节目的专辑信息（根据专辑ID）
  static getStorytellingAlbumInfo(
      String albumId, String pagenum, String perpage, String isAsc,
      {void Function(GetStorytellingAlbumInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "albumId": albumId,
      "pagenum": pagenum,
      "perpage": perpage,
      "isAsc": isAsc
    };
    await DataCenter.instance.sendMsgToDevice("GetStorytellingAlbumInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingAlbumInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.4获取语言节目的播放列表
  static getStorytellingPlaylist(
      String mediaId, String pagenum, String perpage, String isAsc,
      {void Function(GetStorytellingPlaylistResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "mediaId": mediaId,
      "pagenum": pagenum,
      "perpage": perpage,
      "isAsc": isAsc
    };
    await DataCenter.instance.sendMsgToDevice("GetStorytellingPlaylist", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingPlaylistResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.5获取语言节目的推荐
  static getStorytellingPush(String pagenum, String perpage, String pushType,
      {void Function(GetStorytellingAlumlistResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pagenum": pagenum, "perpage": perpage, "pushType": pushType};
    await DataCenter.instance.sendMsgToDevice("GetStorytellingPush", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingAlumlistResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.6搜索语言节目
  static searchStorytelling(String pagenum, String perpage, String searchText,
      {void Function(StorytellingResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "pagenum": pagenum,
      "perpage": perpage,
      "searchText": searchText
    };
    await DataCenter.instance.sendMsgToDevice("SearchStorytelling", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(StorytellingResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.7获取所有主播分类
  static getStoryTellingAnchorCategory(
      {void Function(GetStorytellingAnchorCategoryResponseModel response)
          onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice(
        "GetStoryTellingAnchorCategory", arg, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingAnchorCategoryResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.8获取分类下的主播
  static getStoryTellingAnchor(
      String categoryId, String pageSize, String pageNum,
      {void Function(GetStorytellingAnchorListResponseModel response)
          onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice("GetStoryTellingAnchor", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingAnchorListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.9获取分类下的主播[Normal]
  static getStoryTellingAnchorByNormal(String categoryName,
      String recommendType, String pageSize, String pageNum,
      {void Function(GetStorytellingAnchorListResponseModel response)
          onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryName": categoryName,
      "recommendType": recommendType,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice(
        "GetStoryTellingAnchorByNormal", arg, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingAnchorListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.10获取主播的专辑列表
  static getStoryTellingAnchorAlbum(
      String anchorId, String pageSize, String pageNum,
      {void Function(GetStorytellingResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "anchorId": anchorId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice("GetStoryTellingAnchorAlbum", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.11获取主播信息
  static getStoryTellingAnchorInfo(String anchorId,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"anchorId": anchorId};
    await DataCenter.instance.sendMsgToDevice("GetStoryTellingAnchorInfo", arg,
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

  //5.3.12获取主播的媒体列表
  static getStoryTellingAnchorTrack(
      String anchorId, String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "anchorId": anchorId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice("GetStoryTellingAnchorTrack", arg,
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

  //5.3.13获取所有榜单
  static getStoryTellingRankingList(
      {void Function(GetStoryTellingTopListResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetStoryTellingRankingList", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStoryTellingTopListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.14获取榜单下的专辑
  static getStoryTellingRankingListAlbum(
      String rankingListId, String pageSize, String pageNum,
      {void Function(GetStorytellingRankAlbumListResponseModel response)
          onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "rankingListId": rankingListId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice(
        "GetStoryTellingRankingListAlbum", arg, onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(GetStorytellingRankAlbumListResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //5.3.15获取榜单下的主播
  static getStoryTellingRankingListAnchor(
      String rankingListId, String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "rankingListId": rankingListId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice(
        "GetStoryTellingRankingListAnchor", arg, onResponse: (String reponse) {
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

  //5.3.16获取榜单下的媒体
  static getStoryTellingRankingListTrack(
      String rankingListId, String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "rankingListId": rankingListId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice(
        "GetStoryTellingRankingListTrack", arg, onResponse: (String reponse) {
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

  //5.4.1获取所有电台分类
  static getNetFmCategory(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetNetFmCategory", arg,
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

  //5.4.2获取电台分类下的子电台分类
  static getNetFmByCategory(String categoryId, String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "categoryId": categoryId,
      "pageSize": pageSize,
      "pageNum": pageNum
    };
    await DataCenter.instance.sendMsgToDevice("GetNetFmByCategory", arg,
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

  //5.4.3获取电台排行榜
  static getNetFmTopList(String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageSize": pageSize, "pageNum": pageNum};
    await DataCenter.instance.sendMsgToDevice("GetNetFmTopList", arg,
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

  //5.4.4获取本地电台的电台列表(经纬度方式)
  static getProvinceCodeByLatLng(String latitude, String longitude,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"latitude": latitude, "longitude": longitude};
    await DataCenter.instance.sendMsgToDevice("GetProvinceCodeByLatLng", arg,
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

  //5.4.5获取国家台的电台列表
  static getNetFmNation(String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageSize": pageSize, "pageNum": pageNum};
    await DataCenter.instance.sendMsgToDevice("GetNetFmNation", arg,
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

  //5.4.6获取网络台的电台列表
  static getNetFmNetwork(String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageSize": pageSize, "pageNum": pageNum};
    await DataCenter.instance.sendMsgToDevice("GetNetFmNetwork", arg,
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

  //5.4.7获取省市列表
  static getProvinceCodeCategory(
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetProvinceCodeCategory", arg,
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

  //5.4.8获取省市台的电台列表
  static getNetFmByCode(String pageSize, String pageNum,
      {void Function(ResultCodeResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"pageSize": pageSize, "pageNum": pageNum};
    await DataCenter.instance.sendMsgToDevice("GetNetFmByCode", arg,
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
}

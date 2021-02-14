import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:xj_music/broadcast/play_media_duration_notify.dart';
import 'package:xj_music/broadcast/play_mode_notify.dart';
import 'package:xj_music/broadcast/play_stat_notify.dart';
import 'package:xj_music/broadcast/play_time_notify.dart';
import 'package:xj_music/broadcast/playing_info_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_player_collection_select_page.dart';
import 'package:xj_music/main_page/room_player_delay_timer_page.dart';
import 'package:xj_music/main_page/room_player_playlist_page.dart';
import 'package:xj_music/main_page/room_player_scene_list_page.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/avatar.dart';
import 'package:xj_music/util/const.dart';

import 'room_player_info_time_bar.dart';
import 'room_player_volume_page.dart';

class RoomPlayerInfoPage extends StatefulWidget {
  @override
  _RoomPlayerInfoPageState createState() => _RoomPlayerInfoPageState();
}

class _RoomPlayerInfoPageState extends State<RoomPlayerInfoPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  PlayingInfoNotify _playingInfoNotify;
  PlayModeNotify _playModeNotify;
  PlayStatNotify _playStatNotify;
  ValueNotifier<double> _duration = ValueNotifier(240);
  ValueNotifier<double> _process = ValueNotifier(0);
  Timer _countPlayTimer;
  int _playTime = 0;

  StreamSubscription _playStatSubscription;
  StreamSubscription _playDurationSubScription;
  StreamSubscription _playTimeSubScription;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    _playStatSubscription = DataCenter
        .instance.playStatNotifyStreamController.stream
        .listen(_onPlayStatChanged);
    _playDurationSubScription = DataCenter
        .instance.playingMediaDurationNotifyStreamController.stream
        .listen(_onDurationChanged);
    _playTimeSubScription = DataCenter
        .instance.playTimerNotifyStreamController.stream
        .listen(_onPlayTimeChanged);
    HostApi.getPlayingInfo(
      onResponse: (response) {
        _playingInfoNotify = PlayingInfoNotify(response.json);
        DataCenter.instance.playingInfoNotifyStreamController
            .add(_playingInfoNotify);
      },
      onError: (error) => showToast(error.toString()),
    );
    HostApi.getPlayStat(
      onResponse: (response) {
        _playStatNotify = PlayStatNotify(response.json);
        DataCenter.instance.playStatNotifyStreamController.add(_playStatNotify);
      },
      onError: (error) => showToast(error.toString()),
    );
    HostApi.getPlayMode(
      onResponse: (response) {
        _playModeNotify = PlayModeNotify(response.json);
        DataCenter.instance.playModeNotifyStreamController.add(_playModeNotify);
      },
      onError: (error) => showToast(error.toString()),
    );
    HostApi.getPlayTime(
      onResponse: (response) {
        _playTime = int.tryParse(response.playTime) ?? 0;
      },
      onError: (error) => showToast(error.toString()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _playStatSubscription.cancel();
    _playDurationSubScription.cancel();
    _playTimeSubScription.cancel();
    super.dispose();
  }

  void _onDurationChanged(PlayingMediaDurationNotify durationNotify) {
    _duration.value = double.tryParse(durationNotify.duration) ?? "240";
  }

  void _onPlayTimeChanged(PlayTimeNotify playTimeNotify) {
    _playTime = int.tryParse(playTimeNotify.playTime) ?? 0;
  }

  void _onPlayStatChanged(PlayStatNotify statNotify) {
    if (statNotify.playStat == "playing") {
      _startCountPlayTime();
      _controller.repeat();
    } else {
      _stopCountPlayTime();
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: _playingInfoNotify,
        stream: DataCenter.instance.playingInfoNotifyStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _playingInfoNotify = snapshot.data;
            _controller.stop();
            // _playTime = 0;
            _process.value = 0;
          }
          final playingInfo = _parsePlayingInfo(_playingInfoNotify);
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    playingInfo.item3.isEmpty ? defaultIcon : playingInfo.item3,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAppBar(),
                        sizeHeight8,
                        _buildDivider(),
                        sizeHeight5,
                        _buildEq(),
                      ],
                    ),
                    sizeHeight32,
                    _buildRotateHeader(),
                    sizeHeight32,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSubTitle(playingInfo.item1, playingInfo.item2),
                        sizeHeight32,
                        _buildTimeBar(playingInfo.item4),
                        sizeHeight5,
                        _buildPlayerBar(),
                        sizeHeight5,
                        _buildOperationBar(),
                      ],
                    )
                  ],
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  void _showVolumeBar() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: RoomPlayerVolumePage(),
      ),
    );
  }

  Widget _buildOperationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(
              Icons.volume_up,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => _showVolumeBar()),
        IconButton(
            icon: Icon(
              Icons.add,
              color: _playingInfoNotify?.media is CloudMusicMedia
                  ? Colors.white
                  : Theme.of(context).disabledColor,
              size: 30,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return RoomPlayerCollectionSelectPage(
                        [_playingInfoNotify.media as CloudMusicMedia]);
                  });
            }),
        IconButton(
            icon: Icon(
              Icons.file_download,
              color: _playingInfoNotify?.media is CloudMusicMedia
                  ? Colors.white
                  : Theme.of(context).disabledColor,
              size: 30,
            ),
            onPressed: () {
              HostApi.downloadMusicList(
                "",
                [_playingInfoNotify.media.toJson()],
                onResponse: (response) {
                  if (response.resultCode == "0")
                    showToast("下载成功");
                  else
                    showToast("下载失败");
                },
                onError: (error) => showToast("下载失败"),
              );
            }),
        IconButton(
            icon: Icon(
              Icons.playlist_add_check,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return RoomPlayerSceneListPage();
                },
              );
            }),
        IconButton(
            icon: Icon(
              Icons.alarm,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return RoomPlayerDelayTimerPage();
                },
              );
            }),
      ],
    );
  }

  Widget _buildPlayerBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: StreamBuilder(
            stream: DataCenter.instance.playModeNotifyStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) _playModeNotify = snapshot.data;
              return IconButton(
                  icon: Icon(
                    iconsMap[_playModeNotify?.playMode ?? "normal"],
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    switch (_playModeNotify?.playMode ?? "") {
                      case "normal":
                        HostApi.setPlayMode("shuffle");
                        break;
                      case "shuffle":
                        HostApi.setPlayMode("circle");
                        break;
                      case "circle":
                        HostApi.setPlayMode("single");
                        break;
                      case "single":
                        HostApi.setPlayMode("normal");
                        break;
                      default:
                        break;
                    }
                  });
            },
          ),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: IconButton(
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                HostApi.playCmd("prev");
              }),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: StreamBuilder(
            initialData: _playStatNotify,
            stream: DataCenter.instance.playStatNotifyStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) _playStatNotify = snapshot.data;
              if (_playStatNotify?.playStat == "playing")
                _controller.repeat();
              else
                _controller.stop();
              return IconButton(
                  icon: Icon(
                    _playStatNotify?.playStat == "playing"
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    if (_playStatNotify?.playStat == "playing")
                      HostApi.playCmd("pause");
                    else
                      HostApi.playCmd("resume");
                  });
            },
          ),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: IconButton(
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                HostApi.playCmd("next");
              }),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: IconButton(
              icon: Icon(
                Icons.format_list_bulleted,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return RoomPlayerPlayListPage();
                  },
                );
              }),
        ),
      ],
    );
  }

  static const Map<String, IconData> iconsMap = {
    "normal": Icons.format_line_spacing,
    "shuffle": Icons.shuffle,
    "circle": Icons.loop,
    "single": Icons.settings_backup_restore
  };

  Widget _buildTimeBar(String duration) {
    _duration.value = double.tryParse(duration) ?? 240;
    return AudioProgressIndicator(
      _process,
      height: 90,
      duration: _duration,
      activeColor: Colors.white,
      inactiveColor: Colors.white60,
      progressOnChanged: (progress) {
        if (progress <= 1.0 && progress <= 0.0) _process.value = progress;
        HostApi.setPlayTime(
          "${progress * _duration.value}",
          onError: (error) => showToast("设置播放时间失败"),
          onResponse: (response) {
            if (response.resultCode != "0") showToast("设置播放时间失败");
          },
        );
      },
    );
  }

  Widget _buildSubTitle(String title, String subTitle) {
    return SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            "$title-$subTitle",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
          ),
        ));
  }

  Widget _buildEq() {
    return SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            "标准    音效",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
          ),
        ));
  }

  Widget _buildRotateHeader() {
    if (_playingInfoNotify != null) {
      final playingInfo = _parsePlayingInfo(_playingInfoNotify);
      return RotationTransition(
          turns: _controller,
          child: Avatar(
              url: playingInfo.item3.isEmpty ? defaultIcon : playingInfo.item3,
              radius: 100));
    } else {
      return RotationTransition(
          turns: _controller, child: Avatar(url: defaultIcon, radius: 60));
    }
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
            0.0,
            0.5,
            1.0
          ],
              colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0),
          ])),
    );
  }

  Widget _buildAppBar() {
    String title = "";
    if (_playModeNotify != null) {
      final playingInfo = _parsePlayingInfo(_playingInfoNotify);
      title = playingInfo.item1;
    }
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Routes.pop(context);
              },
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }

  void _startCountPlayTime() {
    _stopCountPlayTime();
    _countPlayTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _playTime++;
      final duration = _duration.value;
      final process = _playTime / duration;
      if (process >= 0.0 && process <= 1.0) _process.value = process;
    });
  }

  void _stopCountPlayTime() {
    _countPlayTimer?.cancel();
  }

  Tuple4<String, String, String, String> _parsePlayingInfo(
      PlayingInfoNotify playingInfo) {
    String title = "";
    String subTitle = "";
    String imageUrl = "";
    String duration = "240";
    if (playingInfo?.media is CloudMusicMedia) {
      final media = (playingInfo.media as CloudMusicMedia);
      title = media.songName;
      for (var i = 0; i < media.singerCount; i++) {
        final singer = media.singerAtIndex(i);
        subTitle += singer.name + " ";
      }
      imageUrl = utf8.decode(base64.decode(media.picUrl));
      duration = media.duration;
    } else if (playingInfo?.media is CloudStoryTellingMedia) {
      final media = (playingInfo.media as CloudStoryTellingMedia);
      title = media.sectionName;
      subTitle = "语音节目";
      imageUrl = media.pic;
      duration = media.duration;
    } else if (playingInfo?.media is LocalMusicMedia) {
      final media = (playingInfo.media as LocalMusicMedia);
      title = media.songName;
      subTitle = "本地音乐";
      imageUrl = media.picUrl;
      duration = media.duration;
    } else if (playingInfo?.media is CloudNetFmMedia) {
      final media = (playingInfo.media as CloudNetFmMedia);
      title = media.name;
      subTitle = "网络电台";
      imageUrl = media.picUrl;
      duration = "240";
    } else if (playingInfo?.media is LocalAuxMedia) {
      title = "AUX";
      subTitle = "AUX";
      imageUrl = defaultIcon;
      duration = "240";
    }
    return Tuple4(title, subTitle, imageUrl, duration);
  }
}

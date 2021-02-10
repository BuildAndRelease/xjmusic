import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:xj_music/broadcast/play_mode_notify.dart';
import 'package:xj_music/broadcast/play_stat_notify.dart';
import 'package:xj_music/broadcast/playing_info_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/avatar.dart';

import 'room_player_info_time_bar.dart';

class RoomPlayerInfoPage extends StatefulWidget {
  @override
  _RoomPlayerInfoPageState createState() => _RoomPlayerInfoPageState();
}

class _RoomPlayerInfoPageState extends State<RoomPlayerInfoPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  PlayingInfoNotify _playingInfoNotify;
  PlayStatNotify _playStatNotify;
  PlayModeNotify _playModeNotify;
  ValueNotifier<Duration> _duration =
      ValueNotifier(const Duration(seconds: 240));
  ValueNotifier<double> _process = ValueNotifier(0);
  Timer _countPlayTimer;
  int _playTime = 0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    _controller.repeat();
    HostApi.getPlayingInfo(
      onResponse: (response) {
        DataCenter.instance.playingInfoNotifyStreamController
            .add(PlayingInfoNotify(response.json));
      },
      onError: (error) => showToast(error.toString()),
    );
    HostApi.getPlayStat(
      onResponse: (response) {
        DataCenter.instance.playStatNotifyStreamController
            .add(PlayStatNotify(response.json));
      },
      onError: (error) => showToast(error.toString()),
    );
    HostApi.getPlayMode(
      onResponse: (response) {
        DataCenter.instance.playModeNotifyStreamController
            .add(PlayModeNotify(response.json));
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
    super.dispose();
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
          }
          final playingInfo = _parsePlayingInfo(_playingInfoNotify);
          _startCountPlayTime();
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: playingInfo.item3,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildAppBar(),
                    sizeHeight8,
                    _buildDivider(),
                    sizeHeight5,
                    _buildEq(),
                    sizeHeight32,
                    _buildRotateHeader(),
                    sizeHeight32,
                    _buildSubTitle(playingInfo.item1, playingInfo.item2),
                    sizeHeight32,
                    _buildTimeBar(playingInfo.item4),
                  ],
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeBar(String duration) {
    _duration.value = Duration(seconds: int.tryParse(duration) ?? 240);
    return AudioProgressIndicator(
      _process,
      height: 90,
      duration: _duration,
      activeColor: Colors.white,
      inactiveColor: Colors.white60,
      progressOnChanged: (progress) {
        _process.value = progress;
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
    return RotationTransition(
        turns: _controller,
        child: StreamBuilder(
          stream: DataCenter.instance.playingInfoNotifyStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playingInfo = _parsePlayingInfo(snapshot.data);
              return Avatar(url: playingInfo.item3, radius: 100);
            } else {
              return Avatar(
                  url:
                      "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg",
                  radius: 60);
            }
          },
        ));
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
                child: StreamBuilder(
                  stream: DataCenter
                      .instance.playingInfoNotifyStreamController.stream,
                  builder: (context, snapshot) {
                    String title = "";
                    if (snapshot.hasData) {
                      final playingInfo = _parsePlayingInfo(snapshot.data);
                      title = playingInfo.item1;
                    }
                    return Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white, fontSize: 20),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  void _startCountPlayTime() {
    _countPlayTimer?.cancel();
    _countPlayTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _playTime++;
      final duration = _duration.value.inMicroseconds / (1000 * 1000);
      _process.value = _playTime / duration;
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
      imageUrl =
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg";
      duration = "240";
    }
    return Tuple4(title, subTitle, imageUrl, duration);
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/avatar.dart';

class RoomMiniPlayerBar extends StatefulWidget {
  @override
  _RoomMiniPlayerBarState createState() => _RoomMiniPlayerBarState();
}

class _RoomMiniPlayerBarState extends State<RoomMiniPlayerBar>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);
    _controller.repeat();
    HostApi.getPlayingInfo(
      onResponse: (response) {
        DataCenter.instance.playingInfoResponseModelNotifier.value = response;
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
    return ValueListenableBuilder(
      valueListenable: DataCenter.instance.playingInfoResponseModelNotifier,
      builder: (context, value, child) => _buildMusicBar(value),
    );
  }

  Widget _buildMusicBar(GetPlayingInfoResponseModel playingInfo) {
    bool _isAux = false;
    String title = "";
    String subTitle = "";
    String imageUrl = "";
    if (playingInfo?.media is CloudMusicMedia) {
      final media = (playingInfo.media as CloudMusicMedia);
      title = media.songName;
      for (var i = 0; i < media.singerCount; i++) {
        final singer = media.singerAtIndex(i);
        subTitle += singer.name + " ";
      }
      imageUrl = utf8.decode(base64.decode(media.picUrl));
    } else if (playingInfo?.media is CloudStoryTellingMedia) {
      final media = (playingInfo.media as CloudStoryTellingMedia);
      title = media.sectionName;
      subTitle = "语音节目";
      imageUrl = media.pic;
    } else if (playingInfo?.media is LocalMusicMedia) {
      final media = (playingInfo.media as LocalMusicMedia);
      title = media.songName;
      subTitle = "本地音乐";
      imageUrl = media.picUrl;
    } else if (playingInfo?.media is CloudNetFmMedia) {
      final media = (playingInfo.media as CloudNetFmMedia);
      title = media.name;
      subTitle = "网络电台";
      imageUrl = media.picUrl;
    } else if (playingInfo?.media is LocalAuxMedia) {
      _isAux = true;
      title = "AUX";
      imageUrl =
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg";
    }
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0.5),
          if (_isAux) sizeHeight8,
          ListTile(
            leading: RotationTransition(
              turns: _controller,
              child: Avatar(url: imageUrl, radius: 24),
            ),
            title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: _isAux
                ? null
                : Text(subTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: _isAux
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_up,
                      size: 30,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_circle_outline_sharp,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.format_list_bulleted,
                          size: 30,
                        ),
                      )
                    ],
                  ),
          ),
          if (_isAux) sizeHeight8,
        ],
      ),
    );
  }
}

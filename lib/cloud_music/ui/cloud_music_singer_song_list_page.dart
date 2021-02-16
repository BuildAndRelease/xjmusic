import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/get_singer_song_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/local_media/ui/music_ui_frame.dart';
import 'package:xj_music/main_page/room_player_collection_select_page.dart';
import 'package:xj_music/routes.dart';

class CloudMusicSingerSongListPage extends StatefulWidget {
  final String singerMid;
  final String singerName;
  final String singerOtherName;
  final String singerPic;

  const CloudMusicSingerSongListPage(
      this.singerMid, this.singerName, this.singerOtherName, this.singerPic);
  @override
  _CloudMusicSingerSongListPageState createState() =>
      _CloudMusicSingerSongListPageState();
}

class _CloudMusicSingerSongListPageState
    extends State<CloudMusicSingerSongListPage> {
  GetSingerSongResponseModel _musicListModel;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int begin = 0;
  int size = 50;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MusicUIFrame(
        headTitle: "歌手",
        title: widget.singerName,
        subTitle: widget.singerOtherName,
        playBtnEnable: true,
        refreshEnable: true,
        multiSelectBtnEnable: true,
        loadMoreEnable: true,
        onLoadMore: _onLoadMore,
        onRefresh: _onRefresh,
        onPlayAll: _onPlayAll,
        imageUrl: widget.singerPic ?? 0,
        onMultiSelect: _onMultiSelectPage,
        refreshController: _refreshController,
        itemCount: () => _musicListModel?.listCount ?? 0,
        widgetAtIndex: (context, index) {
          final media = _musicListModel.listAtIndex(index);
          String singerName = "";
          for (var i = 0; i < media.singers.length; i++) {
            singerName += media.singerAtIndex(i).name + " ";
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: Text("${index + 1}"),
                title: Text(
                  media.songName,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  singerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    _onMoreBtnSelected(context, media);
                  },
                ),
                onTap: () {
                  List list = [];
                  for (var i = 0; i < _musicListModel?.listCount ?? 0; i++) {
                    final dataModel = _musicListModel.listAtIndex(i);
                    list.add(dataModel.toJson());
                  }
                  HostApi.playCloudMusicList(list, media.toJson());
                },
              ),
              Divider(
                height: 0.5,
              )
            ],
          );
        });
  }

  void _onPlayAll() {
    if ((_musicListModel?.listCount ?? 0) > 0 ?? false) {
      List list = [];
      for (var i = 0; i < _musicListModel?.listCount ?? 0; i++) {
        final dataModel = _musicListModel?.listAtIndex(i);
        list.add(dataModel.toJson());
      }
      HostApi.playCloudMusicList(list, list.first);
    } else {
      showToast("此下没有可播放资源");
    }
  }

  void _onRefresh() {
    HostApi.getSingerSong(
      "$begin",
      "quality",
      widget.singerMid,
      "$size",
      onError: (error) {
        showToast("获取歌手歌曲列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        _musicListModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
    );
  }

  void _onLoadMore() {
    HostApi.getSingerSong(
      "${_musicListModel.listCount}",
      "quality",
      widget.singerMid,
      "$size",
      onError: (error) {
        showToast("获取歌手歌曲列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        _musicListModel.combineMoreData(response);
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
    );
  }

  void _onMultiSelectPage() {
    List list = [];
    for (var i = 0; i < _musicListModel?.listCount ?? 0; i++) {
      final dataModel = _musicListModel.listAtIndex(i);
      list.add(dataModel);
    }
    Routes.pushCloudMusicMultiSelectPage(context, list);
  }

  void _onMoreBtnSelected(BuildContext context, BasicMedia media) {
    final theme = Theme.of(context);
    String songName = "";
    String singerName = "";
    String albumName = "";
    if (media is CloudMusicMedia) {
      songName = media.songName;
      for (var i = 0; i < media.singers.length; i++) {
        singerName += media.singerAtIndex(i).name + " ";
      }
      albumName = media.albumName;
    } else if (media is LocalMusicMedia) {
      songName = media.songName;
      for (var i = 0; i < media.singers.length; i++) {
        singerName += media.singerAtIndex(i).name + " ";
      }
      albumName = media.albumName;
    } else if (media is CloudStoryTellingMedia) {
      songName = media.sectionName;
      singerName = media.anchorName;
      albumName = media.sectionName;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          height: 400.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "歌曲 ($songName)",
                    maxLines: 1,
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.skip_next),
                title: Text("下一首播放"),
                onTap: () {
                  HostApi.addToCloudMusicList(
                    [media.toJson()],
                    onError: (error) => showToast("添加到播放列表失败"),
                    onResponse: (response) {
                      if (response.resultCode == "0") {
                        Navigator.of(context).pop();
                        showToast("已添加到播放列表");
                      } else {
                        showToast("添加到播放列表失败");
                      }
                    },
                  );
                },
              ),
              Divider(height: 0.5),
              ListTile(
                leading: Icon(Icons.create_new_folder_outlined),
                title: Text("收藏到歌单"),
                onTap: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return RoomPlayerCollectionSelectPage([media]);
                      });
                },
              ),
              Divider(height: 0.5),
              ListTile(
                leading: Icon(
                  Icons.file_download,
                  color: (media is CloudMusicMedia)
                      ? null
                      : Theme.of(context).disabledColor,
                ),
                title: Text("下载",
                    style: (media is CloudMusicMedia)
                        ? Theme.of(context).textTheme.bodyText2
                        : Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Theme.of(context).disabledColor)),
                onTap: () {
                  HostApi.downloadMusicList(
                    "",
                    [media.toJson()],
                    onResponse: (response) {
                      if (response.resultCode == "0") {
                        showToast("下载成功");
                        Navigator.of(context).pop();
                      } else
                        showToast("下载失败");
                    },
                    onError: (error) => showToast("下载失败"),
                  );
                },
              ),
              Divider(height: 0.5),
              ListTile(
                  leading: Icon(Icons.accessibility,
                      color: Theme.of(context).disabledColor),
                  title: Text(
                    "歌手: $singerName",
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).disabledColor),
                  )),
              Divider(height: 0.5),
              ListTile(
                  leading:
                      Icon(Icons.album, color: Theme.of(context).disabledColor),
                  title: Text(
                    "专辑: $albumName",
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).disabledColor),
                  )),
              Divider(height: 0.5),
            ],
          ),
        );
      },
    );
  }
}

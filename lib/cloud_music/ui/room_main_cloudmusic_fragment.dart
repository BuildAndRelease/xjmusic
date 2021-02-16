import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_new_song_response_model.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/get_recommend_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_player_collection_select_page.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class RoomMainCloudMusicFragment extends StatefulWidget {
  @override
  _RoomMainCloudMusicFragmentState createState() =>
      _RoomMainCloudMusicFragmentState();
}

class _RoomMainCloudMusicFragmentState
    extends State<RoomMainCloudMusicFragment> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetNewSongResponseModel _newSongResponseModel;
  GetRecommendResponseModel _recommendResponseModel;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> newSongWidgets = [];
    for (var i = 0;
        i < min(_newSongResponseModel?.songListCount ?? 0, 7);
        i++) {
      final dataModel = _newSongResponseModel.songListAtIndex(i);
      String singerName = "";
      for (var i = 0; i < dataModel.singers.length; i++) {
        singerName += dataModel.singerAtIndex(i).name + " ";
      }
      newSongWidgets.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text("$i"),
            title: Text(dataModel.songName),
            subtitle: Text(singerName),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _onMoreBtnSelected(context, dataModel);
              },
            ),
            onTap: () {
              List list = [];
              for (var i = 0;
                  i < _newSongResponseModel?.songListCount ?? 0;
                  i++) {
                final dataModel = _newSongResponseModel.songListAtIndex(i);
                list.add(dataModel.toJson());
              }
              HostApi.playCloudMusicList(list, dataModel.toJson());
            },
          ),
          Divider(height: 0.5)
        ],
      ));
    }
    final List<Widget> albumWidgets = [];
    for (var i = 0;
        i < min(_recommendResponseModel?.album?.cn?.length ?? 0, 3);
        i++) {
      final dataModel = _recommendResponseModel?.album?.cn[i];
      albumWidgets.add(_buildRecommendAlbum(
          dataModel.albumName,
          dataModel.singerName,
          utf8.decode(base64.decode(dataModel.picUrl)), () {
        Routes.pushAlbumSongPage(context, dataModel.albumMID,
            dataModel.albumName, dataModel.singerName);
      }));
    }
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMusicCategoryIconButton(FontAwesome.sellsy, "榜单",
                      () => Routes.pushTopListPage(context)),
                  _buildMusicCategoryIconButton(
                      Typicons.user_outline, "歌手", () {}),
                  _buildMusicCategoryIconButton(
                      Typicons.th_large_outline, "歌单", () {}),
                  _buildMusicCategoryIconButton(Icons.radio, "电台", () {}),
                ],
              ),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              GestureDetector(
                onTap: () => Routes.pushAlbumPage(context),
                child: Text("推荐专辑 >"),
              ),
              sizeHeight8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [...albumWidgets],
              ),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              GestureDetector(
                onTap: () => Routes.pushCloudMusicNewSongPage(context),
                child: Text("推荐歌曲 >"),
              ),
              ...newSongWidgets
            ],
          ),
        ));
  }

  Widget _buildRecommendAlbum(
      String title, String subTitle, String imageUrl, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
              fadeInDuration: Duration.zero,
              imageUrl: imageUrl,
              width: 100,
              height: 100,
              imageBuilder: (_, image) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                );
              }),
          SizedBox(
            width: 100,
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              subTitle,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicCategoryIconButton(
      IconData icon, String title, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          sizeHeight8,
          Text(title),
        ],
      ),
    );
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

  void _onRefresh() {
    bool recommendFinish = false;
    bool newSongFinish = false;
    HostApi.getRecommend(
      onError: (error) {
        showToast("获取专辑列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        recommendFinish = true;
        _recommendResponseModel = response;
        if (recommendFinish && newSongFinish && mounted) {
          _refreshController.refreshCompleted();
          setState(() {});
        }
      },
    );
    HostApi.getNewSong(
      "nd",
      onError: (error) {
        showToast("获取专辑列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        newSongFinish = true;
        _newSongResponseModel = response;
        if (recommendFinish && newSongFinish && mounted) {
          _refreshController.refreshCompleted();
          setState(() {});
        }
      },
    );
  }
}

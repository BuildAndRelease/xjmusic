import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_history_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';

class LocalMusicStoryTellingRecentPlayPage extends StatefulWidget {
  @override
  _LocalMusicStoryTellingRecentPlayPageState createState() =>
      _LocalMusicStoryTellingRecentPlayPageState();
}

class _LocalMusicStoryTellingRecentPlayPageState
    extends State<LocalMusicStoryTellingRecentPlayPage> {
  int pageNum = 1;
  int pageSize = 50;
  GetHistoryPlayListResponseModel _playListResponseModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final media = _playListResponseModel.mediaListAtIndex(index);
          String title = "";
          String subTitle = "";
          if (media is CloudMusicMedia) {
            title = media.songName;
            for (var i = 0; i < media.singers.length; i++) {
              subTitle += media.singerAtIndex(i).name + " ";
            }
          } else if (media is LocalMusicMedia) {
            title = media.songName;
            subTitle = "本地音乐";
          } else if (media is CloudStoryTellingMedia) {
            title = media.sectionName;
            subTitle = media.anchorName;
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: Text("$index"),
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                onTap: () {
                  List mediaList = [];
                  for (var i = 0;
                      i < _playListResponseModel.mediaListCount;
                      i++) {
                    mediaList.add(
                        _playListResponseModel.mediaListAtIndex(i).toJson());
                  }
                  HostApi.playCloudStory(media.toJson());
                },
              ),
              Divider(
                height: 0.5,
              )
            ],
          );
        },
        itemCount: _playListResponseModel?.mediaListCount ?? 0,
      ),
    );
  }

  Future _onRefresh() async {
    pageNum = 1;
    HostApi.getHistoryPlayList(
      "$pageNum",
      "$pageSize",
      "cloudStoryTelling",
      onResponse: (response) {
        _playListResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.refreshFailed();
      },
    );
  }

  Future _onLoadMore() async {
    HostApi.getHistoryPlayList(
      "${++pageNum}",
      "$pageSize",
      "cloudStoryTelling",
      onResponse: (response) {
        _playListResponseModel.combineMoreData(response);
        _refreshController.loadComplete();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.loadFailed();
      },
    );
  }
}

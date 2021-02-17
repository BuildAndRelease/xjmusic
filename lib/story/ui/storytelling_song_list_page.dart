import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_story_telling_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/local_media/ui/music_ui_frame.dart';

class StoryTellingSongListPage extends StatefulWidget {
  final String albumId;
  final String albumName;
  final String albumInfo;
  final String albumImg;
  const StoryTellingSongListPage(
      this.albumId, this.albumName, this.albumInfo, this.albumImg);
  @override
  _StoryTellingSongListPageState createState() =>
      _StoryTellingSongListPageState();
}

class _StoryTellingSongListPageState extends State<StoryTellingSongListPage> {
  GetStorytellingPlaylistResponseModel _musicListModel;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int pageNum;
  int perPage;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MusicUIFrame(
        headTitle: "语言节目",
        title: widget.albumName,
        subTitle: widget.albumInfo,
        playBtnEnable: false,
        refreshEnable: true,
        loadMoreEnable: true,
        onRefresh: _onRefresh,
        onLoadMore: _onLoadMore,
        imageUrl: widget.albumImg ?? 0,
        refreshController: _refreshController,
        itemCount: () => _musicListModel?.mediaPlayListCount ?? 0,
        widgetAtIndex: (context, index) {
          final media = _musicListModel.mediaPlayListAtIndex(index);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: Text("${index + 1}"),
                title: Text(
                  media.sectionName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                subtitle: Text(media.anchorName),
                onTap: () {
                  HostApi.playCloudStory(media.toJson());
                },
              ),
              Divider(
                height: 0.5,
              )
            ],
          );
        });
  }

  void _onRefresh() {
    pageNum = 1;
    HostApi.getStorytellingPlaylist(
      widget.albumId,
      "$pageNum",
      "$perPage",
      "true",
      onError: (error) {
        showToast("获取专辑曲目列表失败");
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
    HostApi.getStorytellingPlaylist(
      widget.albumId,
      "${++pageNum}",
      "$perPage",
      "true",
      onError: (error) {
        showToast("获取专辑曲目列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        _musicListModel.combineMoreData(response);
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
    );
  }
}

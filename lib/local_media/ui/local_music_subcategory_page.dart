import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_local_directory_response_model.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

import 'music_ui_frame.dart';

class LocalMusicSubCategoryPage extends StatefulWidget {
  final String dir;
  final String head;
  final String title;
  final String subTitle;
  const LocalMusicSubCategoryPage(
      this.dir, this.head, this.title, this.subTitle);
  @override
  _LocalMusicSubCategoryPageState createState() =>
      _LocalMusicSubCategoryPageState();
}

class _LocalMusicSubCategoryPageState extends State<LocalMusicSubCategoryPage> {
  final ValueNotifier<GetLocalDirectoryResponseModel> _musicListModel =
      ValueNotifier(GetLocalDirectoryResponseModel({}));
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _pageNum = 0;
  int _pageSize = 50;

  @override
  void initState() {
    HostApi.getLocalDirectory(
      widget.dir,
      "$_pageNum",
      "$_pageSize",
      "true",
      onError: (error) => showToast("获取本地音乐失败"),
      onResponse: (response) {
        _musicListModel.value = response;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _musicListModel,
      builder: (context, value, child) {
        return MusicUIFrame(
            headTitle: widget.head,
            title: widget.title,
            subTitle: widget.subTitle,
            playBtnEnable: true,
            refreshEnable: true,
            loadMoreEnable: true,
            onLoadMore: _onLoadMore,
            onRefresh: _onRefresh,
            onPlayAll: _onPlayAll,
            refreshController: _refreshController,
            itemCount: () => value.directoryListCount + value.mediaListCount,
            widgetAtIndex: (context, index) {
              if (index < value.directoryListCount) {
                final directory = value.directoryListAtIndex(index);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).backgroundColor,
                      leading: Icon(Icons.folder_open),
                      title: Text(
                        directory.directoryName,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {
                        Routes.pushLocalMusicSubCategoryPage(context,
                            dir: directory.directoryMid,
                            head: "本地音乐",
                            title: widget.title,
                            subTitle: directory.directoryMid);
                      },
                    ),
                    Divider(
                      height: 0.5,
                    )
                  ],
                );
              } else {
                final media =
                    value.mediaListAtIndex(index - value.directoryListCount);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).backgroundColor,
                      leading: Icon(Icons.music_note),
                      title: Text(
                        (media as LocalMusicMedia).songName,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {
                        HostApi.playLocalMusic(media.toJson());
                      },
                    ),
                    Divider(
                      height: 0.5,
                    )
                  ],
                );
              }
            });
      },
    );
  }

  void _onPlayAll() {
    if (_musicListModel.value.mediaListCount > 0 ?? false) {
      final media = _musicListModel.value.mediaListAtIndex(0);
      HostApi.playLocalMusic(media.toJson());
    } else {
      showToast("此文件夹下没有可播放资源");
    }
  }

  void _onLoadMore() {
    HostApi.getLocalDirectory(
      widget.dir,
      "${++_pageNum}",
      "$_pageSize",
      "true",
      onError: (error) {
        showToast("获取本地音乐失败");
        _refreshController.loadFailed();
      },
      onResponse: (response) {
        _musicListModel.value = response;
        _refreshController.loadComplete();
      },
    );
  }

  void _onRefresh() {
    _pageNum = 0;
    HostApi.getLocalDirectory(
      widget.dir,
      "$_pageNum",
      "$_pageSize",
      "true",
      onError: (error) {
        showToast("获取本地音乐失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        final dataModel = _musicListModel.value;
        dataModel.combineMedia(response);
        _musicListModel.value = dataModel;
        _refreshController.refreshCompleted();
      },
    );
  }
}

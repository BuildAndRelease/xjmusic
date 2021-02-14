import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/host_list/data_model/get_local_directory_response_model.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

import 'local_music_ui_frame.dart';

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
        return LocalMusicUIFrame(
            headTitle: widget.head,
            title: widget.title,
            subTitle: widget.subTitle,
            itemCount: () =>
                _musicListModel.value.directoryListCount +
                _musicListModel.value.mediaListCount,
            widgetAtIndex: (context, index) {
              if (index < _musicListModel.value.directoryListCount) {
                final directory =
                    _musicListModel.value.directoryListAtIndex(index);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
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
                final media = _musicListModel.value.mediaListAtIndex(
                    index - _musicListModel.value.directoryListCount);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text(
                        (media as LocalMusicMedia).songName,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {},
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
}

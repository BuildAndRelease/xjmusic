import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/local_media/ui/local_music_ui_frame.dart';
import 'package:xj_music/routes.dart';

class LocalMusicCategoryPage extends StatefulWidget {
  @override
  _LocalMusicCategoryPageState createState() => _LocalMusicCategoryPageState();
}

class _LocalMusicCategoryPageState extends State<LocalMusicCategoryPage> {
  static const _listItem = [
    "外部存储",
    "内部存储",
    "下载",
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LocalMusicUIFrame(
        headTitle: "本地音乐",
        title: "根目录",
        subTitle: "",
        refreshEnable: false,
        loadMoreEnable: false,
        refreshController: _refreshController,
        itemCount: () => _listItem.length,
        widgetAtIndex: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.folder_open),
                  title: Text(
                    _listItem[index],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  onTap: () {
                    switch (index) {
                      case 0:
                        Routes.pushLocalMusicSubCategoryPage(context,
                            dir: "/storage/sdcard1",
                            head: "本地音乐",
                            title: "外部存储",
                            subTitle: "");
                        break;
                      case 1:
                        Routes.pushLocalMusicSubCategoryPage(context,
                            dir: "/sdcard/InternalStorage/common",
                            head: "本地音乐",
                            title: "内部存储",
                            subTitle: "");
                        break;
                      case 2:
                        Routes.pushLocalMusicSubCategoryPage(context,
                            dir: "/sdcard/InternalStorage/download",
                            head: "本地音乐",
                            title: "我的下载",
                            subTitle: "");
                        break;
                    }
                  },
                ),
                Divider(
                  height: 0.5,
                )
              ],
            ));
  }
}

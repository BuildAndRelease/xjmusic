import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return LocalMusicUIFrame(
        title: "本地音乐",
        subTitle: "根目录",
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
                        Routes.pushLocalMusicSubCategoryPage(context, dir: "/");
                        break;
                      case 1:
                        Routes.pushLocalMusicSubCategoryPage(context, dir: "/");
                        break;
                      case 2:
                        Routes.pushLocalMusicSubCategoryPage(context,
                            dir: "/Download");
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

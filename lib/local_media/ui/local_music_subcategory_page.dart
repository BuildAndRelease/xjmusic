import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_music_ui_frame.dart';

class LocalMusicSubCategoryPage extends StatefulWidget {
  final String dir;
  const LocalMusicSubCategoryPage(this.dir);
  @override
  _LocalMusicSubCategoryPageState createState() =>
      _LocalMusicSubCategoryPageState();
}

class _LocalMusicSubCategoryPageState extends State<LocalMusicSubCategoryPage> {
  static const _listItem = ["外部存储", "内部存储", "下载"];
  @override
  Widget build(BuildContext context) {
    return LocalMusicUIFrame(
        title: "本地音乐",
        subTitle: "根目录",
        itemCount: () => 3,
        widgetAtIndex: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.folder_open),
                  title: Text(
                    _listItem[index],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 0.5,
                )
              ],
            ));
  }
}

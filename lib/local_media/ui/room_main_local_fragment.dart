import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xj_music/routes.dart';

class RoomMainLocalFragment extends StatefulWidget {
  @override
  _RoomMainLocalFragmentState createState() => _RoomMainLocalFragmentState();
}

class _RoomMainLocalFragmentState extends State<RoomMainLocalFragment> {
  bool _showSongMenu = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> songMenuItem = [];
    for (var i = 0; i < 30; i++) {
      songMenuItem.add(ListTile(
        tileColor: Theme.of(context).bottomAppBarColor,
        leading: Text(
          "$i",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        title: Text(
          "我喜欢",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: Icon(Icons.chevron_right),
      ));
      songMenuItem.add(Divider(
        height: 0.5,
      ));
    }
    return ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.library_music,
          ),
          title: Text(
            "本地音乐",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Icon(Icons.chevron_right),
          tileColor: Theme.of(context).bottomAppBarColor,
          onTap: () => Routes.pushLocalMusicCategoryPage(context),
        ),
        Divider(height: 0.5),
        ListTile(
          leading: Icon(
            Icons.restore,
          ),
          title: Text(
            "最近播放",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          tileColor: Theme.of(context).bottomAppBarColor,
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(height: 0.5),
        InkWell(
          focusColor: Colors.grey,
          child: ListTile(
            onTap: () {},
            leading: Icon(
              Icons.file_download,
            ),
            title: Text(
              "下载",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            tileColor: Theme.of(context).bottomAppBarColor,
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        Divider(height: 0.5),
        ListTile(
          leading: Icon(
            Icons.favorite,
          ),
          title: Text(
            "我的收藏",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          tileColor: Theme.of(context).bottomAppBarColor,
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(height: 0.5),
        ListTile(
          tileColor: Theme.of(context).bottomAppBarColor,
          leading: Icon(
            FontAwesome.usb,
          ),
          title: Text(
            "AUX",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Divider(height: 0.5),
        Divider(height: 8, color: Colors.transparent),
        Divider(height: 0.5),
        GestureDetector(
          onTap: () {
            setState(() {
              _showSongMenu = !_showSongMenu;
            });
          },
          child: Container(
              height: 35,
              color: Theme.of(context).bottomAppBarColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    _showSongMenu ? Icons.expand_more : Icons.chevron_right,
                    color: Theme.of(context).disabledColor,
                  ),
                  Text(
                    "自建歌单",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              )),
        ),
        if (!_showSongMenu) Divider(height: 0.5),
        if (_showSongMenu) ...songMenuItem
      ],
    );
  }
}

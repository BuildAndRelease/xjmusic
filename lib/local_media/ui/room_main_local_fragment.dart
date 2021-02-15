import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/host_list/data_model/get_favorite_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

class RoomMainLocalFragment extends StatefulWidget {
  @override
  _RoomMainLocalFragmentState createState() => _RoomMainLocalFragmentState();
}

class _RoomMainLocalFragmentState extends State<RoomMainLocalFragment> {
  bool _showSongMenu = true;
  ValueNotifier<GetFavoritePlayListResponseModel> _playListResponseModel =
      ValueNotifier(GetFavoritePlayListResponseModel({}));
  TextEditingController _textFieldController =
      TextEditingController.fromValue(TextEditingValue(text: ''));

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _playListResponseModel,
      builder: (context, value, child) {
        List<Widget> songMenuItem = [];
        for (var i = 0; i < _playListResponseModel.value.playListCount; i++) {
          final playList = _playListResponseModel.value.playListsAtIndex(i);
          songMenuItem.add(ListTile(
            tileColor: Theme.of(context).bottomAppBarColor,
            leading: Text(
              "$i",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            title: Text(
              playList.playListName,
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
              onTap: () {
                Routes.pushRecentPlayPage(context);
              },
            ),
            Divider(height: 0.5),
            InkWell(
              focusColor: Colors.grey,
              child: ListTile(
                onTap: () {
                  Routes.pushLocalMusicSubCategoryPage(context,
                      dir: "/sdcard/InternalStorage/download",
                      head: "本地音乐",
                      title: "我的下载",
                      subTitle: "");
                },
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
              onTap: () => Routes.pushAlbumFavoriteSetListPage(context),
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
              onTap: () {
                HostApi.switchToAux(
                  "1",
                  onError: (error) => showToast("Aux切换失败"),
                  onResponse: (response) {
                    if (response.resultCode == "0") {
                      showToast("已切换到Aux模式");
                    } else {
                      showToast("Aux切换失败");
                    }
                  },
                );
              },
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
                        onPressed: () {
                          _onAddFavoritePlayList();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Theme.of(context).disabledColor,
                        ),
                        onPressed: () {
                          Routes.pushLocalMusicFavoritePlayListPage(context);
                        },
                      ),
                    ],
                  )),
            ),
            if (!_showSongMenu) Divider(height: 0.5),
            if (_showSongMenu) ...songMenuItem
          ],
        );
      },
    );
  }

  Future _onAddFavoritePlayList() async {
    final playListName = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('新建歌单'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "请输入歌单名（1-10个字符）"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "取消",
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
              TextButton(
                  onPressed: () {
                    final reg = RegExp(r'[\u4e00-\u9fa5_a-zA-Z0-9_]{1,10}');
                    if (reg.hasMatch(_textFieldController.text)) {
                      Navigator.of(context).pop(_textFieldController.text);
                    } else {
                      showToast("仅支持中英文加下划线");
                    }
                  },
                  child: Text(
                    "确定",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Theme.of(context).primaryColor),
                  )),
            ],
          );
        });

    if (playListName != null) {
      HostApi.addFavoritePlayList(
        playListName,
        onError: (error) => showToast("新建歌单失败"),
        onResponse: (response) {
          if (response.resultCode == "0") {
            showToast("新建歌单成功");
            _onRefresh();
          } else {
            showToast("新建歌单失败");
          }
        },
      );
    }
  }

  void _onRefresh() {
    HostApi.getFavoritePlayList(
      onResponse: (response) {
        if (response.resultCode == "0") {
          _playListResponseModel.value = response;
        } else {
          showToast("获取收藏列表失败");
        }
      },
      onError: (error) => showToast("获取收藏列表失败"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_player_collection_select_page.dart';
import 'package:xj_music/routes.dart';

class CloudMusicMultiSelectPage extends StatefulWidget {
  final List medias;
  const CloudMusicMultiSelectPage({this.medias = const []});
  @override
  _CloudMusicMultiSelectPageState createState() =>
      _CloudMusicMultiSelectPageState();
}

class _CloudMusicMultiSelectPageState extends State<CloudMusicMultiSelectPage> {
  List _selectMedia = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          _selectMedia.length > 0 ? '批量操作(${_selectMedia.length})' : '批量操作',
          style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.white,
          onPressed: () {
            Routes.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_selectMedia.length == widget.medias.length) {
                  _selectMedia.clear();
                } else {
                  _selectMedia.addAll(widget.medias);
                }
                setState(() {});
              },
              child: Text(
                _selectMedia.length == widget.medias.length ? "全不选" : "全选",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final media = widget.medias[index];
          String singerName = "";
          for (var i = 0; i < media.singers.length; i++) {
            singerName += media.singerAtIndex(i).name + " ";
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: _selectMedia.contains(media)
                    ? Icon(Icons.check_circle)
                    : Icon(Icons.radio_button_unchecked),
                title: Text(media.songName),
                subtitle: Text(singerName),
                onTap: () {
                  if (_selectMedia.contains(media)) {
                    _selectMedia.remove(media);
                  } else {
                    _selectMedia.add(media);
                  }
                  setState(() {});
                },
              ),
              Divider(
                height: 0.5,
              )
            ],
          );
        },
        itemCount: widget.medias.length,
      ),
      bottomNavigationBar: _buildBottomWidget(),
    );
  }

  Widget _buildBottomWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 0.5),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (_selectMedia.length > 0) {
                    List list = [];
                    for (var i = 0; i < _selectMedia.length; i++) {
                      final dataModel = _selectMedia[i];
                      list.add(dataModel.toJson());
                    }
                    HostApi.playCloudMusicList(list, list.first,
                        onError: (error) => showToast("播放失败"),
                        onResponse: (response) {
                          if (response.resultCode == "0")
                            showToast("播放成功");
                          else
                            showToast("播放失败");
                        });
                  } else {
                    showToast("请选择媒体后再播放");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.play_circle_outline), Text("播放")],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_selectMedia.length > 0) {
                    List list = [];
                    for (var i = 0; i < _selectMedia.length; i++) {
                      final dataModel = _selectMedia[i];
                      list.add(dataModel.toJson());
                    }
                    HostApi.addToCloudMusicList(list,
                        onError: (error) => showToast("播放失败"),
                        onResponse: (response) {
                          if (response.resultCode == "0")
                            showToast("播放成功");
                          else
                            showToast("播放失败");
                        });
                  } else {
                    showToast("请选择媒体后再播放");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.add), Text("稍后播放")],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return RoomPlayerCollectionSelectPage(_selectMedia);
                      });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.add), Text("加入歌单")],
                ),
              ),
              GestureDetector(
                onTap: () {
                  HostApi.downloadMusicList(
                    "",
                    _selectMedia,
                    onError: (error) => showToast("下载失败"),
                    onResponse: (response) {
                      if (response.resultCode == "0")
                        showToast("下载成功");
                      else
                        showToast("下载失败");
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.file_download), Text("下载")],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

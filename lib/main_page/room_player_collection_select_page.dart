import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/host_list/data_model/get_favorite_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';

class RoomPlayerCollectionSelectPage extends StatefulWidget {
  final List medias;

  const RoomPlayerCollectionSelectPage(this.medias);

  @override
  _RoomPlayerCollectionSelectPageState createState() =>
      _RoomPlayerCollectionSelectPageState();
}

class _RoomPlayerCollectionSelectPageState
    extends State<RoomPlayerCollectionSelectPage> {
  ValueNotifier<GetFavoritePlayListResponseModel> _playListResponseModel =
      ValueNotifier(GetFavoritePlayListResponseModel({}));

  @override
  void initState() {
    HostApi.getFavoritePlayList(
      onResponse: (response) {
        _playListResponseModel.value = response;
      },
      onError: (error) => showToast("获取收藏列表失败"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏列表"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _playListResponseModel,
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final media = value.playLists[index];
              String title = media["playListName"].toString();
              String playListId = media["playListId"].toString();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: Theme.of(context).backgroundColor,
                    leading: Icon(Icons.folder),
                    title: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () {
                      List medias = [];
                      for (var i = 0; i < widget.medias.length; i++) {
                        medias.add(widget.medias[i].toJson());
                      }
                      HostApi.addFavoriteMedia(
                        playListId,
                        widget.medias.first.mediaSrc,
                        medias,
                        onResponse: (response) {
                          if (response.resultCode == "0") {
                            Navigator.of(context).pop();
                            showToast("收藏成功");
                          } else
                            showToast("收藏失败");
                        },
                        onError: (error) => showToast("收藏失败"),
                      );
                    },
                  ),
                  Divider(
                    height: 0.5,
                  )
                ],
              );
            },
            itemCount: value.playListCount ?? 0,
          );
        },
      ),
    );
  }
}

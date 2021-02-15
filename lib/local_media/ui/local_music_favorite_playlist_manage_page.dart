import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_favorite_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

class LocalMusicFavoritePlaylistManagePage extends StatefulWidget {
  @override
  _LocalMusicFavoritePlaylistManagePageState createState() =>
      _LocalMusicFavoritePlaylistManagePageState();
}

class _LocalMusicFavoritePlaylistManagePageState
    extends State<LocalMusicFavoritePlaylistManagePage> {
  ValueNotifier<GetFavoritePlayListResponseModel> _playListResponseModel =
      ValueNotifier(GetFavoritePlayListResponseModel({}));
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.primaryColor,
          title: Text(
            '管理自建歌单',
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
        ),
        body: ValueListenableBuilder(
          valueListenable: _playListResponseModel,
          builder: (context, value, child) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final playList =
                      _playListResponseModel.value.playListsAtIndex(index);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        tileColor: Theme.of(context).backgroundColor,
                        leading: Text(playList.playListName),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            HostApi.delFavoritePlayList(
                              playList.playListId,
                              onError: (error) => showToast("删除歌单失败"),
                              onResponse: (response) {
                                if (response.resultCode == "0") {
                                  _onRefresh();
                                } else {
                                  showToast("删除歌单失败");
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Divider(
                        height: 0.5,
                      )
                    ],
                  );
                },
                itemCount: value.playListCount,
              ),
            );
          },
        ));
  }

  void _onRefresh() {
    HostApi.getFavoritePlayList(
      onResponse: (response) {
        if (response.resultCode == "0") {
          _playListResponseModel.value = response;
          _refreshController.refreshCompleted();
        } else {
          showToast("获取收藏列表失败");
          _refreshController.refreshFailed();
        }
      },
      onError: (error) {
        showToast("获取收藏列表失败");
        _refreshController.refreshFailed();
      },
    );
  }
}

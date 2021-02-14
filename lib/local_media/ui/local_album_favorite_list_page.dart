import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_alum_set_favorite_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';

class LocalAlbumFavoriteListPage extends StatefulWidget {
  @override
  _LocalAlbumFavoriteListPageState createState() =>
      _LocalAlbumFavoriteListPageState();
}

class _LocalAlbumFavoriteListPageState
    extends State<LocalAlbumFavoriteListPage> {
  final ValueNotifier<GetAlbumSetFavoriteListResponseModel> _listModel =
      ValueNotifier(GetAlbumSetFavoriteListResponseModel({}));
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    HostApi.getAlbumSetFavoriteList(
      onError: (error) => showToast("获取收藏列表失败，请下拉重试"),
      onResponse: (response) {
        if (response.resultCode == "0") {
          _listModel.value = response;
        } else {
          showToast("获取收藏列表失败，请下拉重试");
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.white,
          onPressed: () {
            Routes.pop(context);
          },
        ),
        title: Text(
          "我的收藏",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: _listModel,
        builder: (context, value, child) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: value.albumSetFolderListCount ?? 0,
              itemBuilder: (context, index) {
                final folder = value.albumSetFolderListAtIndex(index);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).backgroundColor,
                      leading: Icon(Icons.folder_open),
                      title: Text(
                        folder.folderName,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {
                        Routes.pushAlbumFavoriteSetInfoPage(
                            context, folder.folderId);
                      },
                    ),
                    Divider(height: 0.5)
                  ],
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  void _onRefresh() {
    HostApi.getAlbumSetFavoriteList(
      onError: (error) {
        showToast("获取收藏列表失败，请下拉重试");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        if (response.resultCode == "0") {
          _listModel.value = response;
          _refreshController.refreshCompleted();
        } else {
          showToast("获取收藏列表失败，请下拉重试");
          _refreshController.refreshFailed();
        }
      },
    );
  }
}

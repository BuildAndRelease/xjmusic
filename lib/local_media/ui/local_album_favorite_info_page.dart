import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_favorite_set_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/util/const.dart';

class LocalAlbumFavoriteInfoPage extends StatefulWidget {
  final String albumSetId;

  const LocalAlbumFavoriteInfoPage(this.albumSetId);

  @override
  _LocalAlbumFavoriteInfoPageState createState() =>
      _LocalAlbumFavoriteInfoPageState();
}

class _LocalAlbumFavoriteInfoPageState
    extends State<LocalAlbumFavoriteInfoPage> {
  final ValueNotifier<GetFavoriteSetResponseModel> _listModel =
      ValueNotifier(GetFavoriteSetResponseModel({}));
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    HostApi.getFavoriteSet(
      widget.albumSetId,
      albumTypeName: "cloudSingerSet",
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
              itemCount: value.listCount ?? 0,
              itemBuilder: (context, index) {
                final album = value.listAtIndex(index);
                String picUrl = "";
                String title = "";
                String subTitle = "";
                String trailingTitle = "";
                switch (album.albumSetTypeName) {
                  case "cloudAlbumSet":
                    picUrl = (album as CloudAlbumSet).picUrl;
                    title = (album as CloudAlbumSet).name;
                    subTitle = (album as CloudAlbumSet).singerName;
                    trailingTitle = "云音乐专辑";
                    break;
                  case "cloudSingerSet":
                    picUrl = utf8.decode(
                        base64.decode((album as CloudSingerSet).picUrl));
                    title = (album as CloudSingerSet).fsingerName;
                    subTitle = (album as CloudSingerSet).fotherName;
                    trailingTitle = "云音乐歌手";
                    break;
                  case "cloudCategorySet":
                    picUrl = (album as CloudCategorySet).pic;
                    title = (album as CloudCategorySet).title;
                    subTitle = (album as CloudCategorySet).tagIntro;
                    trailingTitle = "云音乐分类";
                    break;
                  case "cloudDissSet":
                    picUrl = (album as CloudDissSet).imgUrl;
                    title = (album as CloudDissSet).dissName;
                    subTitle = (album as CloudDissSet).introduction;
                    trailingTitle = "云音乐歌单";
                    break;
                  case "cloudNetRadioSet":
                    picUrl = (album as CloudNetRadioSet).radioName;
                    title = (album as CloudNetRadioSet).listenNum;
                    subTitle = "${(album as CloudNetRadioSet).listenNum}人在听";
                    trailingTitle = "云音乐电台";
                    break;
                  case "localMusicDirSet":
                    picUrl = defaultIcon;
                    title = (album as LocalMusicDirSet).directoryName;
                    subTitle = null;
                    trailingTitle = "本地音乐";
                    break;
                  case "storyTellingAlbumSet":
                    picUrl = (album as StoryTellingAlbumSet).pic;
                    title = (album as StoryTellingAlbumSet).mediaName;
                    subTitle = (album as StoryTellingAlbumSet).anchorName;
                    trailingTitle = "语言节目专辑";
                    break;
                  case "storyTellingAnchorSet":
                    picUrl = (album as StoryTellingAnchorSet).pic;
                    title = (album as StoryTellingAnchorSet).nickname;
                    subTitle = (album as StoryTellingAnchorSet).verifyTitle;
                    trailingTitle = "语言节目主播";
                    break;
                  default:
                    picUrl = defaultIcon;
                    title = "未知专辑";
                    subTitle = "未知歌手";
                    trailingTitle = "未知媒体信息";
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).backgroundColor,
                      leading: CachedNetworkImage(
                        imageUrl: picUrl,
                      ),
                      title: Text(title),
                      subtitle: Text(subTitle),
                      trailing: Text(trailingTitle),
                      onTap: () {
                        // Routes.pushAlbumFavoriteSetInfoPage(
                        //     context, folder.folderId);
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
    HostApi.getFavoriteSet(
      widget.albumSetId,
      albumTypeName: "cloudSingerSet",
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

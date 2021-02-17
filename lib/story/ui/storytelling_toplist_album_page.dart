import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_rank_album_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

class StorytellingTopListAlbumPage extends StatefulWidget {
  final String topId;
  const StorytellingTopListAlbumPage(this.topId);
  @override
  _StorytellingTopListAlbumPageState createState() =>
      _StorytellingTopListAlbumPageState();
}

class _StorytellingTopListAlbumPageState
    extends State<StorytellingTopListAlbumPage> {
  int pageNum = 0;
  int pageSize = 50;
  GetStorytellingRankAlbumListResponseModel _albumListResponseModel;
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
          '专辑',
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child: GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 3.2 / 4),
          itemBuilder: (context, index) {
            final album = _albumListResponseModel.mediaListAtIndex(index);
            return GestureDetector(
              onTap: () {
                Routes.pushStoryTellingSongListPage(context, album.id,
                    album.mediaName, album.announcer, album.pic);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(imageUrl: album.pic),
                  Text(
                    album.mediaName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
          itemCount: (_albumListResponseModel?.mediaListCount ?? 0),
        ),
      ),
    );
  }

  Future _onRefresh() async {
    pageNum = 0;
    HostApi.getStoryTellingRankingListAlbum(
      widget.topId,
      "$pageSize",
      "$pageNum",
      onResponse: (response) {
        _albumListResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.refreshFailed();
      },
    );
  }

  Future _onLoadMore() async {
    HostApi.getStoryTellingRankingListAlbum(
      widget.topId,
      "$pageSize",
      "${++pageNum}",
      onResponse: (response) {
        _albumListResponseModel.combineMoreData(response);
        _refreshController.loadComplete();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.loadFailed();
      },
    );
  }
}

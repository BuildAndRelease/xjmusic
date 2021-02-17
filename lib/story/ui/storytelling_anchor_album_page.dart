import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_response_model%20.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

class StorytellingAnchorAlbumPage extends StatefulWidget {
  final String anchorId;
  const StorytellingAnchorAlbumPage(this.anchorId);
  @override
  _StorytellingAnchorAlbumPageState createState() =>
      _StorytellingAnchorAlbumPageState();
}

class _StorytellingAnchorAlbumPageState
    extends State<StorytellingAnchorAlbumPage> {
  int pageNum = 1;
  int pageSize = 50;
  GetStorytellingResponseModel _albumListResponseModel;
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
    pageNum = 1;
    HostApi.getStoryTellingAnchorAlbum(
      widget.anchorId,
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
    HostApi.getStoryTellingAnchorAlbum(
      widget.anchorId,
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

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_rank_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class StorytellingToplistPage extends StatefulWidget {
  @override
  _StorytellingToplistPageState createState() =>
      _StorytellingToplistPageState();
}

class _StorytellingToplistPageState extends State<StorytellingToplistPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetStoryTellingTopListResponseModel _topListResponseModel;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<StorytellingRankItem> items = [];
    for (var i = 0;
        i < (_topListResponseModel?.storytellingTopListCount ?? 0);
        i++) {
      final topItem = _topListResponseModel.storytellingTopListAtIndex(i);
      for (var j = 0; j < topItem.listCount; j++) {
        items.add(topItem.listAtIndex(j));
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          '榜单',
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
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final topItem = items[index];
              return GestureDetector(
                onTap: () {
                  Routes.pushStoryTellingTopAlbumListPage(
                      context, topItem.rankingListId);
                },
                child: _buildTopItem(topItem),
              );
            },
            itemCount: items.length,
            itemExtent: 100,
          )),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Widget _buildTopItem(StorytellingRankItem item) {
    final songItem1 = item.songListCount > 0 ? item.songListAtIndex(0) : null;
    final songItem2 = item.songListCount > 1 ? item.songListAtIndex(1) : null;
    final songItem3 = item.songListCount > 2 ? item.songListAtIndex(2) : null;
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizeHeight8,
          Row(
            children: [
              Container(
                color: Theme.of(context).disabledColor,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.pic,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white24,
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              sizeWidth8,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (songItem1 != null)
                  Text(
                    "1.${songItem1.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (songItem2 != null)
                  Text(
                    "2.${songItem2.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (songItem3 != null)
                  Text(
                    "3.${songItem3.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ])
            ],
          ),
          sizeHeight8,
          Divider(height: 0.8)
        ],
      ),
    );
  }

  Future _onRefresh() async {
    HostApi.getStoryTellingRankingList(
      onResponse: (response) {
        _topListResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.refreshFailed();
      },
    );
  }
}

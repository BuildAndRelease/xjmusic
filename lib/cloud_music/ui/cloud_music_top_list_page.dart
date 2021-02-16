import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_top_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class CloudMusicTopListPage extends StatefulWidget {
  @override
  _CloudMusicTopListPageState createState() => _CloudMusicTopListPageState();
}

class _CloudMusicTopListPageState extends State<CloudMusicTopListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetTopListResponseModel _topListResponseModel;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int categoryCount = _topListResponseModel?.topListCateCount ?? 0;
    // int itemCount = 0;
    // List<int> itemCountSperate = [0];

    final List<Item> items = [];
    for (var i = 0; i < categoryCount; i++) {
      final topItem = _topListResponseModel.topListCateAtIndex(i);
      final itemCount = topItem.listCount;
      for (var j = 0; j < itemCount; j++) {
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
                  Routes.pushTopSongPage(context, topItem.date, topItem.id,
                      topItem.name, utf8.decode(base64.decode(topItem.picurl)));
                },
                child: _buildTopItem(topItem),
              );
            },
            itemCount: items.length,
            itemExtent: 100,
          )),
    );
  }

  Widget _buildSectionHeader(String categoryName) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(categoryName),
    );
  }

  Widget _buildTopItem(Item item) {
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
                child: CachedNetworkImage(
                  imageUrl: utf8.decode(base64Decode(item.picurl)),
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              sizeWidth8,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "1.${songItem1.song}-${songItem1.singer}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "2.${songItem2.song}-${songItem2.singer}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "3.${songItem3.song}-${songItem3.singer}",
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
    HostApi.getTopList(
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

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/story/ui/storytelling_anchor_screen_page.dart';

class StorytellingAnchorListPage extends StatefulWidget {
  @override
  _StorytellingAnchorListPageState createState() =>
      _StorytellingAnchorListPageState();
}

class _StorytellingAnchorListPageState
    extends State<StorytellingAnchorListPage> {
  int pageNum = 0;
  int pageSize = 50;
  String categoryId = "10000000";

  dynamic _categoryLisResponseModel;
  dynamic _listResponseModel;
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
          '歌单',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("筛选条件:${categoryNameWithCategoryId(categoryId)}"),
                IconButton(
                    icon: Icon(
                      Typicons.th_large_outline,
                      size: 15,
                    ),
                    onPressed: _showScreeningDialog)
              ],
            ),
          ),
          Expanded(
              child: SmartRefresher(
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
                final diss = _listResponseModel.listAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    // Routes.pushDissSongListPage(
                    //     context,
                    //     diss.dissId,
                    //     diss.dissName,
                    //     diss.introduction,
                    //     utf8.decode(base64.decode(diss.imgUrl)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          width: double.infinity,
                          imageUrl: utf8.decode(base64.decode(diss.imgUrl))),
                      Text(
                        diss.dissName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              itemCount: _listResponseModel?.listCount ?? 0,
            ),
          )),
        ],
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Future _onRefresh() async {
    if (_categoryLisResponseModel != null) {
      pageNum = 0;
      HostApi.getStoryTellingAnchor(
        categoryId,
        "$pageNum",
        "$pageSize",
        onResponse: (response) {
          _listResponseModel = response;
          _refreshController.refreshCompleted();
          if (mounted) setState(() {});
        },
        onError: (error) {
          showToast(error.toString());
          _refreshController.refreshFailed();
        },
      );
    } else {
      HostApi.getStoryTellingAnchorCategory(
        onResponse: (response) {
          _categoryLisResponseModel = response;
          categoryId = _categoryLisResponseModel
              .categoriesAtIndex(0)
              .itemsAtIndex(0)
              .categoryId;
          pageNum = 0;
          HostApi.getStoryTellingAnchor(
            categoryId,
            "$pageNum",
            "$pageSize",
            onResponse: (response) {
              _listResponseModel = response;
              _refreshController.refreshCompleted();
              if (mounted) setState(() {});
            },
            onError: (error) {
              showToast(error.toString());
              _refreshController.refreshFailed();
            },
          );
        },
        onError: (error) {
          showToast("获取歌单分类失败");
          _refreshController.refreshCompleted();
        },
      );
    }
  }

  Future _onLoadMore() async {
    HostApi.getStoryTellingAnchor(
      categoryId,
      "${++pageNum}",
      "$pageSize",
      onResponse: (response) {
        _listResponseModel.combineMoreData(response);
        _refreshController.loadComplete();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.loadFailed();
      },
    );
  }

  String categoryNameWithCategoryId(String categoryId) {
    for (var i = 0;
        i < (_categoryLisResponseModel?.categoriesCount ?? 0);
        i++) {
      final categoryInfo = _categoryLisResponseModel.categoriesAtIndex(i);
      for (var j = 0; j < categoryInfo.itemsCount; j++) {
        final categoryItem = categoryInfo.itemsAtIndex(j);
        if (categoryItem.categoryId == categoryId) {
          return categoryItem.categoryName;
        }
      }
    }
    return "未知歌单";
  }

  void _showScreeningDialog() async {
    // String _tmpCategoryId = categoryId;
    // final result = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text("歌单分类"),
    //         content: SizedBox(
    //           height: 400,
    //           width: 300,
    //           child: StorytellingAnchorScreenPage(
    //               _categoryLisResponseModel, _tmpCategoryId, (categoryId) {
    //             _tmpCategoryId = categoryId;
    //           }),
    //         ),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop(true);
    //               },
    //               child: Text("确认"))
    //         ],
    //       );
    //     });

    // if (result ?? false) {
    //   categoryId = _tmpCategoryId;
    //   _onRefresh();
    // }
  }
}

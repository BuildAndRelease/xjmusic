import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_category_response_model.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_response_model%20.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/story/ui/storytelling_category_screen_page.dart';

class StorytellingCategoryAlbumPage extends StatefulWidget {
  final Category category;
  const StorytellingCategoryAlbumPage(this.category);
  @override
  _StorytellingCategoryAlbumPageState createState() =>
      _StorytellingCategoryAlbumPageState();
}

class _StorytellingCategoryAlbumPageState
    extends State<StorytellingCategoryAlbumPage> {
  int pageNum = 1;
  int pageSize = 50;
  SubCategory _subCategory;
  GetStorytellingResponseModel _albumListResponseModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _subCategory = widget.category.subCategoryListAtIndex(0);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("筛选条件:${_subCategory.categoryName}"),
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
                final album = _albumListResponseModel.mediaListAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    Routes.pushStoryTellingSongListPage(
                        context,
                        album.id,
                        album.mediaName,
                        album.announcer,
                        utf8.decode(base64.decode(album.pic)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          imageUrl: utf8.decode(base64.decode(album.pic))),
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
          )),
        ],
      ),
    );
  }

  Future _onRefresh() async {
    pageNum = 1;
    HostApi.getStorytelling(
      _subCategory.id,
      "$pageNum",
      "$pageSize",
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
    HostApi.getStorytelling(
      _subCategory.id,
      "${++pageNum}",
      "$pageSize",
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

  void _showScreeningDialog() async {
    SubCategory _tmpSubCategory = _subCategory;
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("专辑分类"),
            content: SizedBox(
              height: 400,
              width: 300,
              child: StorytellingCategoryScreenPage(
                  widget.category, _subCategory, (subCategory) {
                _tmpSubCategory = subCategory;
              }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("确认"))
            ],
          );
        });

    if (result ?? false) {
      _subCategory = _tmpSubCategory;
      _onRefresh();
    }
  }
}

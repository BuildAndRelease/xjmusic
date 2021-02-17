import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_anchor_category_list_response_model.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_anchor_list_response_model.dart';
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
  int pageNum = 1;
  int pageSize = 50;
  StorytellingAnchorCategory anchorCategory;
  GetStorytellingAnchorCategoryResponseModel _categoryLisResponseModel;
  GetStorytellingAnchorListResponseModel _listResponseModel;
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
                Text("筛选条件:${anchorCategory?.title ?? ""}"),
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
                final diss = _listResponseModel.categoryListAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    Routes.pushStoryTellingAnchorAlbumListPage(
                        context, diss.uid);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          width: double.infinity, imageUrl: diss.pic),
                      Text(
                        diss.nickname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              itemCount: _listResponseModel?.categoryListCount ?? 0,
            ),
          )),
        ],
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Future _onRefresh() async {
    if (_categoryLisResponseModel != null) {
      pageNum = 1;
      if (anchorCategory.type == "normal") {
        HostApi.getStoryTellingAnchorByNormal(
          anchorCategory.name,
          "hot",
          "$pageSize",
          "$pageNum",
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
        HostApi.getStoryTellingAnchor(
          anchorCategory.id,
          "$pageSize",
          "$pageNum",
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
      }
    } else {
      HostApi.getStoryTellingAnchorCategory(
        onResponse: (response) {
          _categoryLisResponseModel = response;
          anchorCategory = _categoryLisResponseModel.categoryListAtIndex(0);
          pageNum = 1;
          if (anchorCategory.type == "normal") {
            HostApi.getStoryTellingAnchorByNormal(
              anchorCategory.name,
              "hot",
              "$pageSize",
              "$pageNum",
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
            HostApi.getStoryTellingAnchor(
              anchorCategory.id,
              "$pageSize",
              "$pageNum",
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
          }
        },
        onError: (error) {
          showToast("获取歌单分类失败");
          _refreshController.refreshCompleted();
        },
      );
    }
  }

  Future _onLoadMore() async {
    if (anchorCategory.type == "normal") {
      HostApi.getStoryTellingAnchorByNormal(
        anchorCategory.name,
        "hot",
        "$pageSize",
        "${++pageNum}",
        onResponse: (response) {
          _listResponseModel.combineMoreData(response);
          _refreshController.loadComplete();
          if (mounted) setState(() {});
        },
        onError: (error) {
          pageNum--;
          showToast(error.toString());
          _refreshController.loadFailed();
        },
      );
    } else {
      HostApi.getStoryTellingAnchor(
        anchorCategory.id,
        "$pageSize",
        "${++pageNum}",
        onResponse: (response) {
          _listResponseModel.combineMoreData(response);
          _refreshController.loadComplete();
          if (mounted) setState(() {});
        },
        onError: (error) {
          pageNum--;
          showToast(error.toString());
          _refreshController.loadFailed();
        },
      );
    }
  }

  void _showScreeningDialog() async {
    StorytellingAnchorCategory _tmpCategory = anchorCategory;
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("歌单分类"),
            content: SizedBox(
              height: 400,
              width: 300,
              child: StorytellingAnchorScreenPage(
                  _categoryLisResponseModel, _tmpCategory, (category) {
                _tmpCategory = category;
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
      anchorCategory = _tmpCategory;
      _onRefresh();
    }
  }
}

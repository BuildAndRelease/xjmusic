import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_album_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

import 'cloud_music_album_list_screen_page.dart';

class CloudMusicAlbumListPage extends StatefulWidget {
  @override
  _CloudMusicAlbumListPageState createState() =>
      _CloudMusicAlbumListPageState();
}

class _CloudMusicAlbumListPageState extends State<CloudMusicAlbumListPage> {
  int pageNum = 1;
  int pageSize = 50;
  String sort = "1";
  String index = "0";
  String area = "0";
  String time = "0";
  String type = "0";

  GetAlbumResponseModel _albumListResponseModel;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "筛选条件:${sortType[sort]}-${timeType[time]}-${typeType[type]}-${areaType[area]}-${indexType[index]}"),
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
                final album = _albumListResponseModel.listAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    Routes.pushAlbumSongPage(
                        context, album.albumMID, album.name, album.singerName);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          imageUrl: utf8.decode(base64.decode(album.picUrl))),
                      Text(
                        album.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              itemCount: _albumListResponseModel?.listCount ?? 0,
            ),
          )),
        ],
      ),
    );
  }

  Future _onRefresh() async {
    pageNum = 1;
    HostApi.getAlbum(
      area,
      index,
      "$pageNum",
      "$pageSize",
      sort,
      time,
      type,
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
    HostApi.getAlbum(
      area,
      index,
      "${++pageNum}",
      "$pageSize",
      sort,
      time,
      type,
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
    String _tmpSort = sort;
    String _tmpIndex = index;
    String _tmpArea = area;
    String _tmpTime = time;
    String _tmpType = type;
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("专辑分类"),
            content: SizedBox(
              height: 400,
              width: 300,
              child: CloudMusicAlbumListScreenPage(
                  _tmpSort, _tmpIndex, _tmpArea, _tmpTime, _tmpType,
                  (type, index) {
                switch (type) {
                  case "area":
                    _tmpArea = index;
                    break;
                  case "index":
                    _tmpIndex = index;
                    break;
                  case "sort":
                    _tmpSort = index;
                    break;
                  case "time":
                    _tmpTime = index;
                    break;
                  case "type":
                    _tmpType = index;
                    break;
                  default:
                    break;
                }
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
      sort = _tmpSort;
      area = _tmpArea;
      index = _tmpIndex;
      time = _tmpTime;
      type = _tmpType;
      _onRefresh();
    }
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_singer_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';

import 'cloud_music_singer_list_screen_page.dart';

class CloudMusicSingerListPage extends StatefulWidget {
  @override
  _CloudMusicSingerListPageState createState() =>
      _CloudMusicSingerListPageState();
}

class _CloudMusicSingerListPageState extends State<CloudMusicSingerListPage> {
  int pageNum = 1;
  int pageSize = 50;
  String index = "all";
  String area = "all_all";

  GetSingerResponseModel _listResponseModel;
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
          '歌手',
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
                Text("筛选条件:${singerAreaInfo[area]}-${singerIndexInfo[index]}"),
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
                final singer = _listResponseModel.listAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    Routes.pushSingerSongListPage(
                        context,
                        singer.fsingerMid,
                        singer.fsingerName,
                        singer.fotherName,
                        utf8.decode(base64.decode(singer.picUrl)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          width: double.infinity,
                          imageUrl: utf8.decode(base64.decode(singer.picUrl))),
                      Text(
                        singer.fsingerName,
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
    );
  }

  Future _onRefresh() async {
    pageNum = 1;
    HostApi.getSinger(
      area,
      index,
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

  Future _onLoadMore() async {
    HostApi.getSinger(
      area,
      index,
      "${++pageNum}",
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

  void _showScreeningDialog() async {
    String _tmpIndex = index;
    String _tmpArea = area;
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("专辑分类"),
            content: SizedBox(
              height: 400,
              width: 300,
              child: CloudMusicSingerListScreenPage(_tmpIndex, _tmpArea,
                  (type, index) {
                switch (type) {
                  case "area":
                    _tmpArea = index;
                    break;
                  case "index":
                    _tmpIndex = index;
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
      area = _tmpArea;
      index = _tmpIndex;
      _onRefresh();
    }
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_radio_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';

class CloudMusicRadioListPage extends StatefulWidget {
  @override
  _CloudMusicRadioListPageState createState() =>
      _CloudMusicRadioListPageState();
}

class _CloudMusicRadioListPageState extends State<CloudMusicRadioListPage> {
  GetRadioResponseModel _listResponseModel;
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
    List<RadioList> _radioList = [];
    for (var i = 0; i < (_listResponseModel?.groupListCount ?? 0); i++) {
      final group = _listResponseModel.groupListAtIndex(i);
      for (var j = 0; j < group.radioListCount; j++) {
        final radio = group.radioListAtIndex(j);
        _radioList.add(radio);
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          '电台',
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
          Expanded(
              child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 3.2 / 4),
              itemBuilder: (context, index) {
                final radio = _radioList[index];
                return GestureDetector(
                  onTap: () {
                    HostApi.getRadioSong(
                      radio.radioId,
                      onResponse: (response) {
                        List list = [];
                        for (var i = 0; i < response?.songsCount ?? 0; i++) {
                          final dataModel = response?.songsAtIndex(i);
                          list.add(dataModel.toJson());
                        }
                        HostApi.playCloudMusicList(list, list.first);
                      },
                      onError: (error) => showToast("获取电台歌曲失败"),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          width: double.infinity,
                          imageUrl: utf8.decode(base64.decode(radio.radioImg))),
                      Text(
                        radio.radioName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              itemCount: (_radioList?.length ?? 0),
            ),
          )),
        ],
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Future _onRefresh() async {
    HostApi.getRadio(
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_netradio_toplist_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/themes/const.dart';

import '../../routes.dart';

class NetRadioNetFmListPage extends StatefulWidget {
  @override
  _NetRadioNetFmListPageState createState() => _NetRadioNetFmListPageState();
}

class _NetRadioNetFmListPageState extends State<NetRadioNetFmListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetNetFmTopListResponseModel _topListResponseModel;
  int pageNum = 1;
  int pageSize = 50;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          '网络台',
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              final topItem = _topListResponseModel.topListItemAtIndex(index);
              return GestureDetector(
                onTap: () {
                  HostApi.playCloudNetFm(topItem.toJson());
                },
                child: _buildTopItem(topItem),
              );
            },
            itemCount: _topListResponseModel?.topListCateCount ?? 0,
            itemExtent: 100,
          )),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Widget _buildTopItem(NetFmTopInfo item) {
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
                  imageUrl: item.picUrl,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              sizeWidth8,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                sizeHeight8,
                Text(
                  item.programName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 14),
                ),
                Text("${(double.tryParse(item.playCount) / 10000)}万人在听",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).disabledColor, fontSize: 14)),
              ]),
              Expanded(child: const SizedBox()),
              Icon(
                Icons.play_circle_outline,
                size: 30,
                color: Theme.of(context).disabledColor,
              ),
              sizeWidth8
            ],
          ),
          sizeHeight8,
          Divider(height: 0.8)
        ],
      ),
    );
  }

  Future _onRefresh() async {
    pageNum = 1;
    HostApi.getNetFmNetwork(
      pageSize.toString(),
      pageNum.toString(),
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

  Future _onLoadMore() async {
    HostApi.getNetFmNetwork(
      pageSize.toString(),
      (++pageNum).toString(),
      onResponse: (response) {
        _topListResponseModel.combineMoreData(response);
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

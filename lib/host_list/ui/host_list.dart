import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';
import 'package:xj_music/broadcast/search_host_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/host_list/ui/host_item.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/icon_font.dart';

class HostListPage extends StatefulWidget {
  @override
  _HostListPageState createState() => _HostListPageState();
}

class _HostListPageState extends State<HostListPage> {
  Timer _searchHostTimer;
  int _retrySearchHostInSeconds = 3;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  StreamSubscription _searchHostSubscription;
  final List<Tuple2<SearchHostNotify, GetHostRoomListResponseModel>>
      _searchedHost = [];

  @override
  void initState() {
    super.initState();
    _searchHostSubscription = DataCenter
        .instance.searchHostNotifyStreamController.stream
        .listen(_onSearchedHost);
    _startSearchHost();
  }

  @override
  void dispose() {
    _searchHostTimer?.cancel();
    _refreshController.dispose();
    _searchHostSubscription.cancel();
    super.dispose();
  }

  void _startSearchHost() {
    DataCenter.instance.searchHost();
    _searchHostTimer?.cancel();
    _searchHostTimer =
        Timer(Duration(seconds: ++_retrySearchHostInSeconds), _startSearchHost);
  }

  void _onSearchedHost(SearchHostNotify searchHostNotify) {
    final contain = _searchedHost.length > 0
        ? _searchedHost.firstWhere(
            (element) => element.item1.deviceId == searchHostNotify.deviceId)
        : null;
    if (contain == null) {
      HostApi.getHostRoomList(
        searchHostNotify.deviceId,
        ipAddress: searchHostNotify.deviceIp,
        onResponse: (response) {
          _searchedHost.add(Tuple2(searchHostNotify, response));
          if (mounted) setState(() {});
        },
      );
    }
  }

  void _onRefresh() async {
    _searchedHost.clear();
    setState(() {});
    _retrySearchHostInSeconds = 3;
    _startSearchHost();
    Future.delayed(Duration(seconds: _retrySearchHostInSeconds), () {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          '设备列表',
          style: theme.textTheme.bodyText2,
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          itemBuilder: (context, index) {
            final device = _searchedHost[index];
            return HostItem(device);
          },
          itemExtent: 100.0,
          itemCount: _searchedHost.length,
        ),
      ),
    );
  }
}

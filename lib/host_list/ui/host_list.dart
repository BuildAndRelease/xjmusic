import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/data_center/socket.dart';

import 'dart:convert' as convert;

class HostListPage extends StatefulWidget {
  @override
  _HostListPageState createState() => _HostListPageState();
}

class _HostListPageState extends State<HostListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TCPSocket tcpSocket;
  final searchHost = {
    "direct": "request",
    "sendId": "BA7700012E27F79B837E",
    "arg": {},
    "cmd": "SearchHost",
    "recvId": "ffffffffffffffffffff",
    "direction": "request"
  };

  final getTopList = {
    "direct": "request",
    "sendId": "BA7700012E27F79B837E",
    "arg": {},
    "cmd": "GetTopList",
    "recvId": "BA5000002E27F79B837E",
    "direction": "request"
  };

  // {
  //   "sendId": "BA50EC01001122334455",
  //   "recvId": "BA50001001122334456",
  //   "cmd": "SearchHost",
  //   "direction": "request",
  //   "arg": {}
  // };

  @override
  void initState() {
    super.initState();
    tcpSocket = TCPSocket("192.168.0.105", "20090", _onResponse, _onError);
    tcpSocket.initTCPSocket();
  }

  void _onResponse(String response) {
    final t = convert.jsonDecode(response);
    print(t);
  }

  void _onError(Error error) {
    print(error);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    tcpSocket
        .sendMsg(convert.Utf8Encoder().convert(convert.jsonEncode(getTopList)));

    // udpSocket
    // .sendMsg(convert.Utf8Encoder().convert(convert.jsonEncode(searchHost)));
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
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
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
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
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(children: [Text('data')]),
                ListTile(
                  title: Text(
                    '房间名称$index',
                    style: theme.textTheme.bodyText2,
                  ),
                  trailing: Switch(
                    value: false,
                    onChanged: (changed) {},
                    activeColor: theme.primaryColor,
                  ),
                )
              ],
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}

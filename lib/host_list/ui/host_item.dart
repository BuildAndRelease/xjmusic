import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:xj_music/broadcast/search_host_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class HostItem extends StatefulWidget {
  final Tuple2<SearchHostNotify, GetHostRoomListResponseModel> device;
  const HostItem(this.device);

  @override
  _HostItemState createState() => _HostItemState();
}

class _HostItemState extends State<HostItem> {
  ValueKey<int> _switchButtonKey = const ValueKey(0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> rooms = [];
    for (int i = 0; i < widget.device.item2.roomListCount; i++) {
      final room = widget.device.item2.roomInfoAtIndex(i);
      rooms.add(GestureDetector(
        onTap: () {
          if (room.devStat == "open") {
            DataCenter.instance.searchHostNotify = widget.device.item1;
            DataCenter.instance.roomInfoResponseModel = room;
            DataCenter.instance.roomListResponseModel = widget.device.item2;
            Routes.pushRoomMainPage(context);
          }
        },
        child: Container(
          color: theme.backgroundColor,
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(room.roomName),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  key: _switchButtonKey,
                  value: room.devStat == "open",
                  onChanged: (value) {
                    HostApi.setDevStat(
                      room.roomId,
                      room.devStat == "open" ? "close" : "open",
                      ipAddress: widget.device.item1.deviceIp,
                      onResponse: (response) {
                        room.devStat = response.devStat;
                        room.modifyDevStat(response.devStat);
                        _switchButtonKey = ValueKey(_switchButtonKey.value + 1);
                        if (mounted) setState(() {});
                        if (response.devStat == "open") {
                          DataCenter.instance.searchHostNotify =
                              widget.device.item1;
                          DataCenter.instance.roomInfoResponseModel = room;
                          DataCenter.instance.roomListResponseModel =
                              widget.device.item2;
                          Routes.pushRoomMainPage(context);
                        }
                      },
                      onError: (error) {
                        showToast(error.toString());
                      },
                    );
                  },
                  activeColor: theme.primaryColor,
                  trackColor: theme.disabledColor,
                ),
              ),
            ],
          ),
        ),
      ));
      rooms.add(Divider(height: 0.5));
    }
    return Column(
      children: [
        Divider(height: 0.5),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(DataCenter.instance.deviceModelWithDeviceId(
                deviceId: widget.device.item1.deviceId)),
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
              onPressed: () => _onMoreBtnSelected(context),
            ),
          ]),
        ),
        Divider(height: 0.5),
        ...rooms
      ],
    );
  }

  void _onMoreBtnSelected(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SafeArea(
            child: Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "主机:${DataCenter.instance.deviceModelWithDeviceId(deviceId: widget.device.item1.deviceId)}"),
                ],
              ),
              sizeHeight8,
              _deviceInfoItem(Icons.home,
                  "房间: ${widget.device.item2.roomListCount}", null, theme),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              _deviceInfoItem(
                  Icons.perm_device_info,
                  "机型: ${DataCenter.instance.deviceModelWithDeviceId(deviceId: widget.device.item1.deviceId)}",
                  null,
                  theme),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              _deviceInfoItem(Icons.wifi, "IP: ${widget.device.item1.deviceIp}",
                  null, theme),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              _deviceInfoItem(Fontelico.spin5, "重启", () {}, theme),
              sizeHeight8,
              Divider(height: 0.5),
            ],
          ),
        ));
      },
    );
  }

  Widget _deviceInfoItem(
      IconData iconData, String desc, Function onTap, ThemeData theme) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: onTap != null
                ? theme.textTheme.bodyText1.color
                : theme.disabledColor,
            size: 22,
          ),
          sizeWidth16,
          Text(
            desc,
            style: onTap != null
                ? theme.textTheme.bodyText1
                : theme.textTheme.bodyText1
                    .copyWith(color: theme.disabledColor),
          ),
        ],
      ),
    );
  }
}

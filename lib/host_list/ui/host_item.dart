import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:xj_music/broadcast/search_host_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';

class HostItem extends StatelessWidget {
  final Tuple2<SearchHostNotify, GetHostRoomListResponseModel> device;

  const HostItem(this.device);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.lightBlue,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(DataCenter.instance
                .deviceModelWithDeviceId(device.item1.deviceId)),
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ]),
        )
      ],
    );
  }
}

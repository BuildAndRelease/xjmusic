import 'dart:async';

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:xj_music/broadcast/search_host_notify.dart';
import 'package:xj_music/data_center/socket.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';
import 'package:xj_music/host_list/data_model/host_model.dart';
import 'package:xj_music/util/shared_util.dart';

class DataCenter {
  static DataCenter get instance => _getInstance();
  static DataCenter _instance;

  // ignore: prefer_constructors_over_static_methods
  static DataCenter _getInstance() {
    return _instance ??= DataCenter._internal();
  }

  // 当前设备标识
  String deviceUUID = "";

  // 当前操作通道标识
  get currentRoomId => roomInfoResponseModel?.roomId ?? "";
  // 当前操作主机标识
  get currentHostId => searchHostNotify?.deviceId ?? "";
  // 当前操作主机IP
  get currentHostIp => searchHostNotify?.deviceIp ?? "";
  // 当前操作主机名称
  get currentRoomName => roomInfoResponseModel?.roomName;
  // 当前主机信息
  SearchHostNotify searchHostNotify;
  // 当前主机房间列表信息
  GetHostRoomListResponseModel roomListResponseModel;
  // 当前房间信息
  GetHostRoomInfoResponseModel roomInfoResponseModel;
  // 当前房间播放内容
  ValueNotifier<GetPlayingInfoResponseModel> playingInfoResponseModelNotifier =
      ValueNotifier(null);

  UDPSocket udpSocket;

  // 广播列表
  StreamController<SearchHostNotify> searchHostNotifyStreamController =
      StreamController<SearchHostNotify>.broadcast();

  DataCenter._internal() {
    _init();
  }

  Future _init({int retryInSecond = 5}) async {
    try {
      deviceUUID = await SharedUtil.instance.getString("device_uuid");
      if (deviceUUID == null) {
        deviceUUID = "BACO" + randomString(16, from: 65, to: 90);
        await SharedUtil.instance.saveString("device_uuid", deviceUUID);
      }
      udpSocket = UDPSocket("$UDPPort", onUdpResponse, null);
      await udpSocket.initUDPSocket();
    } catch (e) {
      print(e);
      await Future.delayed(Duration(seconds: retryInSecond));
      _init(retryInSecond: retryInSecond + 1);
    }
  }

  String deviceModelWithDeviceId({String deviceId}) {
    if ((deviceId ?? currentHostId).startsWith("BA50") ?? false) {
      return "S5";
    } else {
      return "未知机型";
    }
  }

  void searchHost() {
    final requestProtocol = requestJsonMap(cmd: "SearchHost");
    udpSocket?.sendMsg(
        convert.Utf8Encoder().convert(convert.jsonEncode(requestProtocol)));
  }

  void onUdpResponse(String jsonString) {
    final json = convert.jsonDecode(jsonString);
    if (json != null && json is Map) {
      final sendId = json["sendId"].toString();
      final direction = json["direction"].toString();
      if (sendId == deviceUUID || direction == "request") return;
      switch (json['cmd'].toString()) {
        case "SearchHost":
          final searchHostNotify = SearchHostNotify(json);
          searchHostNotifyStreamController.add(searchHostNotify);
          break;
      }
    }
  }

  Future sendMsgToDevice(String cmd, Map arg,
      {String recvId,
      String ipAddress,
      String port,
      void Function(String response) onResponse,
      void Function(Error error) onError}) async {
    final socket = TCPSocket(ipAddress ?? DataCenter.instance.currentHostIp,
        port ?? "$TCPPort", onResponse, onError);
    try {
      await socket.initTCPSocket();
      final requestProtocol = DataCenter.instance.requestJsonMap(
          cmd: cmd,
          arg: arg,
          recvId: recvId ?? DataCenter.instance.currentRoomId);
      socket.sendMsg(
          convert.Utf8Encoder().convert(convert.jsonEncode(requestProtocol)));
    } catch (e) {
      print(e);
    }
  }

  Map requestJsonMap({@required String cmd, Map arg, String recvId}) {
    return {
      "sendId": deviceUUID,
      "recvId": recvId ?? "FFFFFFFFFFFFFFFFFFFF",
      "cmd": cmd,
      "direction": "request",
      "arg": arg ?? {}
    };
  }
}

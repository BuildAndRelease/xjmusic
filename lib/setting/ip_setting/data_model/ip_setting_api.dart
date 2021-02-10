import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'system_ip_info_response_model.dart';

class IpSettingApi {
  //4.28.1获取主机IP信息
  static getServerIpInfo(
      {void Function(ServerIpInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {};
    await DataCenter.instance.sendMsgToDevice("GetServerIpInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ServerIpInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }

  //4.28.2设置主机IP信息
  static setServerIpInfo(String autoSetIp, String address, String gateway,
      String netmask, String dns1, String dns2,
      {void Function(ServerIpInfoResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {
      "autoSetIp": autoSetIp,
      "address": address,
      "gateway": gateway,
      "netmask": netmask,
      "dns1": dns1,
      "dns2": dns2
    };
    await DataCenter.instance.sendMsgToDevice("SetServerIpInfo", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(ServerIpInfoResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}

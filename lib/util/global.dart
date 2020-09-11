import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:random_string/random_string.dart';

import 'universal_platform.dart';

/// 全局数据存储
class Global {
  ///版本信息
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 媒体信息
  static MediaQueryData mediaInfo;

  static DeviceInfo _deviceInfo;

  static PackageInfo packageInfo;

  /// 设备信息
  static DeviceInfo get deviceInfo {
    if (_deviceInfo == null) {
      _deviceInfo = DeviceInfo();
      _getDeviceInfo();
    }
    return _deviceInfo;
  }

  static Future<void> _getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (UniversalPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _deviceInfo.systemName = iosInfo.systemName;
      _deviceInfo.systemVersion = iosInfo.systemVersion;
      _deviceInfo.identifier = iosInfo.identifierForVendor;
    } else if (UniversalPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _deviceInfo.systemName = "Android";
      _deviceInfo.systemVersion = androidInfo.version.release;
      _deviceInfo.identifier = androidInfo.androidId;
    }
  }
}

class DeviceInfo {
  String systemName = "Web";
  String systemVersion = "";
  String identifier = randomString(10);
  String thumbDir = "";
}

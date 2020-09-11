import 'dart:io';

import 'package:flutter/foundation.dart';

class UniversalPlatform {
  static String get operatingSystem =>
      kIsWeb ? "web" : Platform.operatingSystem;

  static bool get isWeb => kIsWeb;

  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  static bool get isWindows => !kIsWeb && Platform.isWindows;

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;

  static bool get isLinux => !kIsWeb && Platform.isLinux;

  static bool get isPc => isMacOS || isWindows || isLinux;

  static bool get isMobileDevice => isIOS || isAndroid;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';

import 'app.dart';
import 'data_center/data_center.dart';
import 'util/universal_platform.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 隐藏键盘，防止设备屏幕viewPadding获取不正确
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  DataCenter.instance;
  // 竖屏显示
  unawaited(SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]));

  // 设置Android头部的导航栏透明
  if (UniversalPlatform.isAndroid) {
    final systemUiOverlayStyle =
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  runApp(App());
}

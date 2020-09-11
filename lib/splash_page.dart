import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pedantic/pedantic.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:xj_music/routes.dart';

import 'util/const.dart';
import 'util/global.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((d) async {
      Global.mediaInfo = MediaQuery.of(context);
      // 初始化一次
      Global.deviceInfo;
      Global.packageInfo = kIsWeb
          ? PackageInfo(appName: appName)
          : await PackageInfo.fromPlatform();
      unawaited(Routes.pushHomePage(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        color: Colors.white,
        padding:
            EdgeInsets.only(bottom: 48 + MediaQuery.of(context).padding.bottom),
        child: WebsafeSvg.asset(
          "assets/launch_screen_logo.svg",
          width: 146,
          height: 32,
        ));
  }
}

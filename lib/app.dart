import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

import 'routes.dart';
import 'themes/dark_theme.dart';
import 'themes/skin.dart';
import 'util/global.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  static bool _showPerformanceOverlay = false;
  static bool _saveLayer = false;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      radius: 5,
      textPadding: const EdgeInsets.all(10),
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale.fromSubtags(languageCode: 'zh'),
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
          ],
          showPerformanceOverlay: _showPerformanceOverlay,
          // 使用了saveLayer的图像会显示为棋盘格式并随着页面刷新而闪烁
          checkerboardOffscreenLayers: _saveLayer,
          // 做了缓存的静态图像图片在刷新页面使不会改变棋盘格的颜色；如果棋盘格颜色变了，说明被重新缓存，这是我们要避免的
          // checkerboardRasterCacheImages: true,
          title: '西鲸音乐',
          theme: Skin.themeData,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: Routes.showLaunchPage(),
          navigatorKey: Global.navigatorKey),
    );
  }
}

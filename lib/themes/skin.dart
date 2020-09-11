import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'default_theme.dart';

enum SkinType { ligth, dark }

/// 皮肤管理类
class Skin {
  /// 当前主题
  static DefaultTheme theme = DefaultTheme()..init();

  /// 当前主题数据
  static ThemeData themeData = theme.themeData;

  /// 当前主题类型
  static SkinType skinType = SkinType.dark;

  /// 更改皮肤
  static void change(SkinType mode) {
    if (skinType == mode) return;
    skinType = mode;
    print('skinType : $skinType');
    if (mode == SkinType.ligth) {
      theme = DefaultTheme()..init();
      themeData = theme.themeData;
    } else {
      theme = DarkTheme().init();
      themeData = theme.themeData;
    }
    // App.refresh();
  }
}

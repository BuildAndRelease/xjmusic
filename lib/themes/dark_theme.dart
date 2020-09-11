import 'package:flutter/material.dart';

import 'const.dart';
import 'default_theme.dart';
import 'no_splash.dart';

/// 深色主题
class DarkTheme extends DefaultTheme {
  @override
  DarkTheme init() {
    super.init();
    themeData = darkTheme;
    backgoundColor3 = const Color(0xFF1B1D20);
    backgoundColor4 = const Color(0xFF363940);
    backgoundColor5 = const Color(0xFF27292E);
    return this;
  }
}

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primaryColor,
    primaryColor: primaryColor,
    primaryColorBrightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashFactory: const NoSplashFactory(),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF1F2125),
      iconTheme: const IconThemeData(color: Colors.white, size: 20),
      actionsIconTheme: const IconThemeData(),
      textTheme: TextTheme(
        button: Typography.blackCupertino.button,
        headline6: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
        color: const Color(0xFFFFFFFF).withOpacity(0.06),
        space: 0,
        thickness: 0.5),
    scaffoldBackgroundColor: const Color(0xFF1F2125), // b1
    backgroundColor: const Color(0xFF2B2E33), // b2
    iconTheme: const IconThemeData(color: Color(0xFF737780)),
    textTheme: TextTheme(
      headline4: Typography.whiteCupertino.headline4.copyWith(
          fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),

      headline5: Typography.whiteCupertino.headline5.copyWith(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),

      /// 灰色字体
      bodyText1: Typography.whiteCupertino.bodyText1.copyWith(
        color: const Color(0xFF919499),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),

      /// [已修订]
      /// 深色字体
      bodyText2: Typography.whiteCupertino.bodyText2.copyWith(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnBorderRadius)),
    ),
    hintColor: const Color(0xFFD9D9D9),
    dialogBackgroundColor: const Color(0xFF363940));

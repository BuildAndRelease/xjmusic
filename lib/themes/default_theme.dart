import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xj_music/util/universal_platform.dart';

import 'const.dart';
import 'no_splash.dart';

const int _bluePrimaryValue = 0xFF6179F2;
MaterialColor primaryColor = const MaterialColor(
  _bluePrimaryValue,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },
);

/// 默认主题，浅色
class DefaultTheme {
  /// 异常态颜色
  static const Color dangerColor = Color(0xFFF24848);

  // 全局颜色
  Color colorFA = const Color(0xFFFAFAFA);
  Color colorED = const Color(0xFFEDEDED);
  Color color22 = const Color(0xFF222222);
  Color color33 = const Color(0xFF333333);
  Color color66 = const Color(0xFF666666);
  Color color99 = const Color(0xFF999999);
  Color colorBB = const Color(0xFFBBBBBB);
  Color colorDD = const Color(0xFFDDDDDD);
  Color colorD8 = const Color(0xFFD8D8D8);
  Color colorEE = const Color(0xFFEEEEEE);
  Color colorF6 = const Color(0xFFF6F6F6);

  // 全局样式
  TextStyle tagStyle;
  TextStyle timeStyle;
  TextStyle replyStyle;
  TextStyle numStyle;
  TextStyle nameStyle;
  TextStyle smallNameStyle;
  TextStyle contentStyle;
  TextStyle appBarButtonTextStyle;
  TextStyle appBarButtonTextActiveStyle;

  /// 主题数据
  ThemeData themeData;

  /// 背景颜色
  Color backgoundColor3;
  Color backgoundColor4;
  Color backgoundColor5;

  void init() {
    tagStyle = TextStyle(color: color66, fontSize: 12);
    timeStyle = TextStyle(color: color99, fontSize: 14);
    replyStyle = TextStyle(color: color99, fontSize: 14);
    numStyle = TextStyle(color: color66, fontSize: 14);
    contentStyle = const TextStyle(fontSize: 16);
    nameStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: color99,
    );
    smallNameStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: color99,
    );
    themeData = ThemeData(
      primarySwatch: primaryColor,
      brightness: Brightness.light,
      cursorColor: primaryColor,
      primaryColorBrightness: Brightness.light,
      highlightColor: Colors.transparent,
      splashFactory: const NoSplashFactory(),
      toggleableActiveColor: primaryColor,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        actionsIconTheme: IconThemeData(color: primaryColor),
        textTheme: TextTheme(
          button: Typography.blackCupertino.button,
          headline6: const TextStyle(
            color: Color(0xFF17181A),
            fontSize: 18,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
          color: const Color(0xFF919499).withOpacity(0.2),
          space: 0,
          thickness: 0.5),
      scaffoldBackgroundColor: const Color(0xFFF2F3F5),
      // a1
      backgroundColor: Colors.white,
      // a2
      iconTheme: const IconThemeData(color: Color(0xFF363940)),
      textTheme: TextTheme(
        headline4: Typography.whiteCupertino.headline4.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF17181A),
        ),

        // [已修订]
        headline5: Typography.blackCupertino.headline5.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF17181A),
        ),

        /// 灰色字体
        bodyText1: Typography.blackCupertino.bodyText1.copyWith(
          color: const Color(0xFF6D6F73),
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.41,
        ),

        /// 深色字体
        bodyText2: Typography.blackCupertino.bodyText2.copyWith(
          color: const Color(0xFF1F2125),
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.41,
        ),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnBorderRadius)),
      ),
      disabledColor: const Color(0xFF919499),
    );

    appBarButtonTextStyle = themeData.appBarTheme.textTheme.button.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: const Color(0xFF4F545C));

    backgoundColor3 = Colors.white;
    backgoundColor4 = const Color(0xFFE0E2E6);
    backgoundColor5 = Colors.white;
  }

  static Widget activityIndicator({double radius = 10.0, Color color}) {
    return UnconstrainedBox(
        child: UniversalPlatform.isIOS
            ? CupertinoActivityIndicator(radius: radius)
            : SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: CircularProgressIndicator(
                  backgroundColor: color,
                  strokeWidth: 3,
                ),
              ));
  }

  static Widget defaultLoadingIndicator({double size = 10, Color color}) {
    return Center(child: activityIndicator(radius: size, color: color));
  }
}

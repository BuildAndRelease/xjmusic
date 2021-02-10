import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'universal_platform.dart';

bool isNotNullAndEmpty(String str) {
  return str != null && str.isNotEmpty;
}

TextPainter calculateTextHeight(BuildContext context, String value,
    TextStyle style, double maxWidth, int maxLines) {
  ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
  final TextPainter painter = TextPainter(
      locale: Localizations.localeOf(context),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      text: TextSpan(text: value, style: style));
  painter.layout(maxWidth: maxWidth);
  return painter;
}

/// 格式化数量（万，亿）保持内容不操过4位
String formatNum(int value) {
  if (value > 100000000) {
    // ignore: prefer_interpolation_to_compose_strings
    return (value / 100000000).toStringAsFixed(1) + " 亿";
  } else if (value > 10000000) {
    // ignore: prefer_interpolation_to_compose_strings
    return (value / 100000000).toStringAsFixed(2) + " 亿";
  } else if (value > 1000000) {
    // ignore: prefer_interpolation_to_compose_strings
    return (value / 10000).toStringAsFixed(0) + " 万";
  } else if (value > 10000) {
    // ignore: prefer_interpolation_to_compose_strings
    return (value / 10000).toStringAsFixed(1) + " 万";
  } else {
    return value.toString();
  }
}

/// 格式化秒
String formatSecond(int value) {
  int _value = value;
  String ret = '';
  if (_value >= 24 * 60 * 60) {
    final tmp = (_value / (24 * 60 * 60)).floor();
    ret += '$tmp天';
    _value -= tmp * 24 * 60 * 60;
    return ret;
  }

  if (_value >= 60 * 60) {
    final tmp = (_value / (60 * 60)).floor();
    ret += '${twoDigits(tmp)}:';
    _value -= tmp * 60 * 60;
  } else {
    ret += '00:';
  }

  if (_value >= 60) {
    final tmp = (_value / 60).floor();
    ret += '${twoDigits(tmp)} ';
    _value -= tmp * 24 * 60 * 60;
  } else {
    ret += '00';
  }
  return ret;
}

/// 把日期格式化为 MM-DD HH:MM
// String formatDate(int time) {
//   DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
//   Duration diff = DateTime.now().difference(date);
// if (diff.inSeconds < 60) {
//   return "刚刚";
// } else if (diff.inHours < 1) {
//   return "${diff.inMinutes}分钟前";
// } else if (diff.inDays < 1) {
//   return "今天 ${twoDigits(date.hour)}:${twoDigits(date.minute)}";
// } else if (diff.inDays < 2) {
//   return "昨天 ${twoDigits(date.hour)}:${twoDigits(date.minute)}";
// } else

//   if (diff.inDays < 365) {
//     return "${date.month}-${date.day} ${_twoDigits(date.hour)}:${_twoDigits(date.minute)}";
//   } else {
//     return "${date.year}-${date.month}-${date.day} ${_twoDigits(date.hour)}:${_twoDigits(date.minute)}";
//   }
// }
String formatDate2Str(DateTime date, {bool showToday = false}) {
  List<String> args;
  final now = DateTime.now();
  if (date.year == now.year) {
    if (date.month == now.month) {
      if (date.day == now.day) {
        // 如果是同一天，显示为 10:00
        if (showToday)
          args = const ["今天 ", HH, ":", nn];
        else
          args = const [HH, ":", nn];
      } else if (date.add(const Duration(days: 1)).day == now.day) {
        // 如果是昨天，显示为 昨天 10:00
        args = const ["昨天 ", HH, ":", nn];
      } else {
        args = [m, "月", d, "日 ", HH, ":", nn];
      }
    } else {
      // 如果���同���年，显示为 11-11 02-02 10:00
      args = [m, "月", d, "日 ", HH, ":", nn];
    }
  } else {
    // 如果不是同一年，显示为 1999-11-11 02-02 10:00
    args = [yyyy, "年", m, "月", d, "日 ", HH, ":", nn];
  }
  return formatDate(date, args);
}

/// 显示倒计时
String formatCountdownTime(int seconds) {
  final hour = (seconds / 3600).floor();
  final minute = ((seconds - hour * 3600) / 60).floor();
  final second = seconds % 60;
  if (hour < 1) return "${twoDigits(minute)}:${twoDigits(second)}";
  return "${twoDigits(hour)}:${twoDigits(minute)}:${twoDigits(second)}";
}

String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

Future delay(Function func, [int milliseconds = 300]) {
  return Future.delayed(Duration(milliseconds: milliseconds), func);
}

String getPlatform() {
  if (UniversalPlatform.isAndroid) return 'android';
  if (UniversalPlatform.isIOS) return 'ios';
  return 'web';
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

TextStyle copyWithFs12(TextStyle ts) {
  return ts.copyWith(fontSize: 12);
}

String subRichString(String str, int len) {
  // 删除emoji表情
  final sRunes = str.runes;
  return sRunes.length > len ? String.fromCharCodes(sRunes, 0, len) : str;
}

const minSizeConstraint = 48.0;
const maxSizeConstraint = 225.0;
Tuple3 getImageSize(double _width, double _height, {BoxFit defaultFit}) {
  double width = _width ?? 120;
  width = width > 0 ? width : 120;
  double height = _height ?? 225;
  height = height > 0 ? height : 225;
  BoxFit fit = defaultFit ?? BoxFit.contain;
  if (width / height > (maxSizeConstraint / minSizeConstraint)) {
    // 横线长图
    width = maxSizeConstraint;
    height = minSizeConstraint;
    fit = BoxFit.fitHeight;
  } else if (height / width > (maxSizeConstraint / minSizeConstraint)) {
    // 纵向长图
    width = minSizeConstraint;
    height = maxSizeConstraint;
    fit = BoxFit.fitWidth;
  } else if (width > maxSizeConstraint || height > maxSizeConstraint) {
    final s = min(maxSizeConstraint / width, maxSizeConstraint / height);
    width = _width * s;
    height = _height * s;
  } else if (width < minSizeConstraint || height < minSizeConstraint) {
    final s = max(minSizeConstraint / width, minSizeConstraint / height);
    width = _width * s;
    height = _height * s;
  }
  return Tuple3(width, height, fit);
}

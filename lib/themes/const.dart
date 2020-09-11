import 'package:flutter/material.dart';
import 'package:xj_music/util/utils.dart';

const sizeWidth5 = SizedBox(width: 5);
const sizeHeight2 = SizedBox(height: 2);
const sizeHeight5 = SizedBox(height: 5);
const sizeHeight6 = SizedBox(height: 6);
const sizeHeight8 = SizedBox(height: 8);
const sizeWidth4 = SizedBox(width: 4);
const sizeWidth8 = SizedBox(width: 8);
const sizeWidth16 = SizedBox(width: 16);
const sizeWidth20 = SizedBox(width: 20);
const sizeWidth24 = SizedBox(width: 24);
const sizeWidth32 = SizedBox(width: 32);
const sizeWidth10 = SizedBox(width: 10);
const sizeWidth12 = SizedBox(width: 12);
const sizeHeight10 = SizedBox(height: 10);
const sizeHeight16 = SizedBox(height: 16);
const sizeHeight32 = SizedBox(height: 32);
const sizeHeight50 = SizedBox(height: 50);
const sizeHeight80 = SizedBox(height: 80);
const sizeHeight34 = SizedBox(height: 34);
const sizeWidth15 = SizedBox(width: 15);
const sizeHeight15 = SizedBox(height: 15);
const sizeHeight12 = SizedBox(height: 12);
const sizeHeight20 = SizedBox(height: 20);
const sizeHeight24 = SizedBox(height: 24);
const sizedBox = SizedBox();
const spacer = Spacer();
const divider = Divider(thickness: 0.5);
const transparentDivider = SizedBox(height: 0.5);

const dlgBorderRadius = 12.0;
const btnBorderRadius = 6.0;
const littleBtnBorderRadius = 6.0;

class CustomColor {
  final BuildContext context;
  bool isDart;

  CustomColor(this.context) : isDart = isDarkMode(context);

  static const red = Color(0xFFF24848);
  static const fontGrey = Color(0xFFD9D9D9);
  static const grey = Color(0xFF787F8D);

  /// 不可以颜色
  Color get disableColor => const Color(0xFF919499);

  /// 通用背景颜色
  Color get globalBackgroundColor3 =>
      isDart ? const Color(0xFF363940) : const Color(0xFFF2F3F5);
  Color get globalBackgroundColor4 =>
      isDart ? const Color(0xFF2E3137) : Colors.white;

  /// 特殊背景色
  Color get backgroundColor1 =>
      isDart ? const Color(0xFF1F2125) : const Color(0xFFE0E2E6);
  Color get backgroundColor2 => isDart ? const Color(0xFF2B2E33) : Colors.white;
  Color get backgroundColor3 => isDart ? const Color(0xFF1B1D20) : Colors.white;
  Color get backgroundColor4 =>
      isDart ? const Color(0xFF363940) : const Color(0xFFE0E2E6);
  Color get backgroundColor5 => isDart ? const Color(0xFF27292E) : Colors.white;

  /// 用在对话框中
  Color get backgroundColor6 => isDart ? const Color(0xFF1F2125) : Colors.white;
  Color get backgroundColor7 =>
      isDart ? const Color(0xFF2B2E33) : const Color(0xFFF2F3F5);
  Color get backgroundColor8 => isDart ? const Color(0xFF363940) : Colors.white;
}

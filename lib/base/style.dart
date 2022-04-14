import 'dart:developer';

import 'package:alita/base/color.dart';
import 'package:alita/base/dimen.dart';
import 'package:flutter/material.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap3 = SizedBox(width: Dimens.gapDp3);
  static const Widget hGap4 = SizedBox(width: Dimens.gapDp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gapDp5);
  static const Widget hGap6 = SizedBox(width: Dimens.gapDp6);
  static const Widget hGap8 = SizedBox(width: Dimens.gapDp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gapDp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gapDp12);
  static const Widget hGap15 = SizedBox(width: Dimens.gapDp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gapDp16);
  static const Widget hGap20 = SizedBox(width: Dimens.gapDp20);
  static const Widget hGap24 = SizedBox(width: Dimens.gapDp24);
  static const Widget hGap40 = SizedBox(width: Dimens.gapDp40);

  /// 垂直间隔
  static const Widget vGap3 = SizedBox(height: Dimens.gapDp3);
  static const Widget vGap4 = SizedBox(height: Dimens.gapDp4);
  static Widget vGap5 = const SizedBox(height: Dimens.gapDp5);
  static Widget vGap6 = const SizedBox(height: Dimens.gapDp6);
  static Widget vGap8 = const SizedBox(height: Dimens.gapDp8);
  static Widget vGap10 = const SizedBox(height: Dimens.gapDp10);
  static Widget vGap12 = const SizedBox(height: Dimens.gapDp12);
  static Widget vGap15 = const SizedBox(height: Dimens.gapDp15);
  static Widget vGap16 = const SizedBox(height: Dimens.gapDp16);
  static Widget vGap20 = const SizedBox(height: Dimens.gapDp20);
  static Widget vGap24 = const SizedBox(height: Dimens.gapDp24);
  static Widget vGap25 = const SizedBox(height: Dimens.gapDp25);
  static Widget vGap40 = const SizedBox(height: Dimens.gapDp40);
  static Widget vGap48 = const SizedBox(height: Dimens.gapDp48);
  static Widget vGap60 = const SizedBox(height: Dimens.gapDp60);

  static Widget hGap(double w) {
    return SizedBox(width: w);
  }

  static Widget vGap(double h) {
    return SizedBox(height: h);
  }

  static Widget line = Container(height: 0.6, color: const Color(0xFFEEEEEE));
}

class AppTheme {
  static getThemeData(int color) {
    log('getThemeData===================================$color');
    ThemeData themData = ThemeData(
      primaryColor: Color(color == 0 ? Colors.red.value : color),
      fontFamily: 'Aleo',
    );
    return themData;
  }
}

class TextStyles {
  static TextStyle textStyle(
      {double fontSize = Dimens.fontSp12,
      Color color = Colors.white,
      FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: TextDecoration.none,
        fontWeight: fontWeight);
  }

  static TextStyle textRed12 = textStyle(color: Colors.red);
  static TextStyle textBlue12 = textStyle(color: Colors.blueAccent);
  static TextStyle textWhite12 = textStyle();
  static TextStyle textGreyC12 = textStyle(color: greyCColor);
  static TextStyle textGrey12 = textStyle(color: Colors.grey);
  static TextStyle textDark12 = textStyle(color: grey3Color);
  static TextStyle textBoldDark12 = textStyle(color: Colors.black);
  static TextStyle textBoldWhile12 = textStyle(fontWeight: FontWeight.bold);

  static TextStyle textWhite14 = textStyle(fontSize: Dimens.fontSp14);
  static TextStyle textRed14 =
      textStyle(fontSize: Dimens.fontSp14, color: Colors.red);
  static TextStyle textReader14 =
      textStyle(fontSize: Dimens.fontSp14, color: readerMainColor);
  static TextStyle textBlue14 =
      textStyle(fontSize: Dimens.fontSp14, color: Colors.blueAccent);
  static TextStyle textGreyC14 =
      textStyle(fontSize: Dimens.fontSp14, color: greyCColor);
  static TextStyle textGrey14 =
      textStyle(fontSize: Dimens.fontSp14, color: Colors.grey);
  static const TextStyle textDark14 = TextStyle(
      fontSize: Dimens.fontSp14,
      color: grey3Color,
      decoration: TextDecoration.none);
  static TextStyle textBoldDark14 = textStyle(
      fontSize: Dimens.fontSp14,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textBoldWhile14 =
      textStyle(fontSize: Dimens.fontSp14, fontWeight: FontWeight.bold);
  static TextStyle textBoldBlue14 = textStyle(
      fontSize: Dimens.fontSp14,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent);

  static TextStyle textReader16 =
      textStyle(fontSize: Dimens.fontSp16, color: readerMainColor);
  static TextStyle textRed16 =
      textStyle(fontSize: Dimens.fontSp16, color: Colors.red);
  static TextStyle textBlue16 =
      textStyle(fontSize: Dimens.fontSp16, color: Colors.blueAccent);
  static TextStyle textWhite16 = textStyle(fontSize: Dimens.fontSp16);
  static TextStyle textGreyC16 =
      textStyle(fontSize: Dimens.fontSp16, color: greyCColor);
  static TextStyle textGrey16 =
      textStyle(fontSize: Dimens.fontSp16, color: Colors.grey);
  static TextStyle textDark16 =
      textStyle(fontSize: Dimens.fontSp16, color: grey3Color);
  static TextStyle textBoldDark16 = textStyle(
      fontSize: Dimens.fontSp16,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textBoldWhile16 = textStyle(
      fontSize: Dimens.fontSp16,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  static TextStyle textBoldDark20 = textStyle(
      fontSize: Dimens.fontSp20,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark26 = TextStyle(
      fontSize: Dimens.fontSp26,
      color: Colors.black,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold);

  static TextStyle textBoldWhile40 =
      textStyle(fontSize: Dimens.fontSp40, fontWeight: FontWeight.w400);

  static TextStyle textBoldDark40 = textStyle(
      fontSize: Dimens.fontSp40,
      fontWeight: FontWeight.w400,
      color: Colors.black);

  static const TextStyle kHintTextStyle = TextStyle(color: Colors.white54);

  static const TextStyle kLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
}

final kBoxDecorationStyle = BoxDecoration(
    color: const Color(0xFF6CA8F1),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))
    ]);

const IconThemeData lightIconTheme = IconThemeData(color: Colors.black54);

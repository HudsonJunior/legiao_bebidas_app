import 'package:flutter/material.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/constraints.dart';

class AppStyle {
  static final _textTheme = TextTheme(
    headline1: const TextStyle(
      fontSize: Constraints.fontSizeTitle,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline2: const TextStyle(
      fontSize: Constraints.fontSizeNormal,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'Made Tommy',
    ),
    headline3: const TextStyle(
      fontSize: Constraints.fontSizeLarge,
      fontWeight: FontWeight.bold,
    ),
    headline4: const TextStyle(
      fontSize: Constraints.fontSizeLarge,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline5: const TextStyle(
      fontSize: Constraints.fontSizeNormal,
      fontWeight: FontWeight.bold,
    ),
    headline6: const TextStyle(
      fontSize: Constraints.fontSizeLarger,
      color: Palette.primary,
    ),
    bodyText1: const TextStyle(
      fontSize: Constraints.fontSizeSmall,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyText2: const TextStyle(
      fontSize: Constraints.fontSizeLarge,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    subtitle1: const TextStyle(
      fontSize: Constraints.fontSizeLarge,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  static final theme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Palette.dark,
    primaryColor: Palette.primary,
    accentColor: Colors.white,
    hintColor: Palette.lightBlack,
    textTheme: _textTheme,
    fontFamily: 'Made Tommy',
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  );
}

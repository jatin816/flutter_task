import 'package:flutter/material.dart';


const Color mColorAccent = Color(0xffe01f25);
const Color mColorWhite = Colors.white;
const Color mColorBlack = Colors.black;
const Color mColorDivider = Colors.black12;
const Color mColorTransparent = Colors.transparent;

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class ColorConst {

  static const primaryDarkGreen = Color(0xFF276464);
  static const primaryLightGreen = Color(0xFFF1F7F7);
  static const lightGreen = Color(0xFF276464);
  static const backgroundGrey = Color(0xFFE4E4E4);
  static const background = Color(0xFFE9E9E9);
  static const loginBackground = Color(0xFFF2F2F2);
  static const backgroundDark = Color(0xFF2C3E50);
  static const yellowColor = Color(0xFF2C3E50);
  static const darkBackgroundColor = Color(0xCC0C2831);
  static const white = Color(0xffffffff);
  static const black = Color(0xff333333);
  static const white80 = Color(0xccffffff);
  static const white70 = Color(0xb2ffffff);
  static const lightGray = Color(0xFF808080);
  static const gray = Colors.grey;
  static const transparent = Colors.transparent;
  static const coral = Color(0xfffc4d4d);
  static const lightBlue = Color(0xFF1ABC9C);
  static const snackBarBackgroundColor = Color(0xFF2C3E50);
}
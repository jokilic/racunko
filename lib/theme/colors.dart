import 'package:flutter/material.dart';

abstract class RacunkoColors {
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF82859C);
  static const darkBlue = Color(0xFF2C346B);
  static const blue = Color(0xFF4B57B2);
  static const red = Color(0xFFED8080);
  static const green = Color(0xFF5CA27F);
}

class RacunkoColorsExtension extends ThemeExtension<RacunkoColorsExtension> {
  final Color white;
  final Color grey;
  final Color darkBlue;
  final Color blue;
  final Color red;
  final Color green;

  RacunkoColorsExtension({
    required this.white,
    required this.grey,
    required this.darkBlue,
    required this.blue,
    required this.red,
    required this.green,
  });

  @override
  ThemeExtension<RacunkoColorsExtension> copyWith({
    Color? white,
    Color? grey,
    Color? darkBlue,
    Color? blue,
    Color? red,
    Color? green,
  }) =>
      RacunkoColorsExtension(
        white: white ?? this.white,
        grey: grey ?? this.grey,
        darkBlue: darkBlue ?? this.darkBlue,
        blue: blue ?? this.blue,
        red: red ?? this.red,
        green: green ?? this.green,
      );

  @override
  ThemeExtension<RacunkoColorsExtension> lerp(
    covariant ThemeExtension<RacunkoColorsExtension>? other,
    double t,
  ) {
    if (other is! RacunkoColorsExtension) {
      return this;
    }

    return RacunkoColorsExtension(
      white: Color.lerp(white, other.white, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
    );
  }
}

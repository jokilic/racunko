import 'package:flutter/material.dart';

abstract class RacunkoColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
}

class RacunkoColorsExtension extends ThemeExtension<RacunkoColorsExtension> {
  final Color white;
  final Color black;

  RacunkoColorsExtension({
    required this.white,
    required this.black,
  });

  @override
  ThemeExtension<RacunkoColorsExtension> copyWith({
    Color? white,
    Color? black,
  }) =>
      RacunkoColorsExtension(
        white: white ?? this.white,
        black: black ?? this.black,
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
      black: Color.lerp(black, other.black, t)!,
    );
  }
}

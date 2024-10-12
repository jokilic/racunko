import 'package:flutter/material.dart';

abstract class RacunkoColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF2B2D42);
  static const grey = Color(0xFF82859C);
  static const darkBlue = Color(0xFF2C346B);
  static const blue = Color(0xFF4B57B2);
  static const red = Color(0xFFED8080);
  static const green = Color(0xFF5CA27F);
}

class RacunkoColorsExtension extends ThemeExtension<RacunkoColorsExtension> {
  final Color background;
  final Color disabled;
  final Color text;
  final Color invertedText;
  final Color primary;
  final Color error;
  final Color success;

  RacunkoColorsExtension({
    required this.background,
    required this.disabled,
    required this.text,
    required this.invertedText,
    required this.primary,
    required this.error,
    required this.success,
  });

  @override
  ThemeExtension<RacunkoColorsExtension> copyWith({
    Color? background,
    Color? disabled,
    Color? text,
    Color? invertedText,
    Color? primary,
    Color? error,
    Color? success,
  }) =>
      RacunkoColorsExtension(
        background: background ?? this.background,
        disabled: disabled ?? this.disabled,
        text: text ?? this.text,
        invertedText: invertedText ?? this.invertedText,
        primary: primary ?? this.primary,
        error: error ?? this.error,
        success: success ?? this.success,
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
      background: Color.lerp(background, other.background, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      text: Color.lerp(text, other.text, t)!,
      invertedText: Color.lerp(invertedText, other.invertedText, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

import 'package:flutter/material.dart';

abstract class RacunkoTextStyles {
  static const title = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static const subtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );
  static const button = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );
  static const text = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static const inputText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static const hintText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const fab = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );
}

class RacunkoTextThemesExtension extends ThemeExtension<RacunkoTextThemesExtension> {
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle button;
  final TextStyle text;
  final TextStyle inputText;
  final TextStyle hintText;
  final TextStyle fab;

  const RacunkoTextThemesExtension({
    required this.title,
    required this.subtitle,
    required this.button,
    required this.text,
    required this.inputText,
    required this.hintText,
    required this.fab,
  });

  @override
  ThemeExtension<RacunkoTextThemesExtension> copyWith({
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? button,
    TextStyle? text,
    TextStyle? inputText,
    TextStyle? hintText,
    TextStyle? fab,
  }) =>
      RacunkoTextThemesExtension(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        button: button ?? this.button,
        text: text ?? this.text,
        inputText: inputText ?? this.inputText,
        hintText: hintText ?? this.hintText,
        fab: fab ?? this.fab,
      );

  @override
  ThemeExtension<RacunkoTextThemesExtension> lerp(
    covariant ThemeExtension<RacunkoTextThemesExtension>? other,
    double t,
  ) {
    if (other is! RacunkoTextThemesExtension) {
      return this;
    }

    return RacunkoTextThemesExtension(
      title: TextStyle.lerp(title, other.title, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      text: TextStyle.lerp(text, other.text, t)!,
      inputText: TextStyle.lerp(inputText, other.inputText, t)!,
      hintText: TextStyle.lerp(hintText, other.hintText, t)!,
      fab: TextStyle.lerp(fab, other.fab, t)!,
    );
  }
}

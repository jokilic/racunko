import 'package:flutter/material.dart';

abstract class RacunkoTextStyles {
  static const error = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
}

class RacunkoTextThemesExtension extends ThemeExtension<RacunkoTextThemesExtension> {
  final TextStyle error;

  const RacunkoTextThemesExtension({
    required this.error,
  });

  @override
  ThemeExtension<RacunkoTextThemesExtension> copyWith({
    TextStyle? error,
  }) =>
      RacunkoTextThemesExtension(
        error: error ?? this.error,
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
      error: TextStyle.lerp(error, other.error, t)!,
    );
  }
}

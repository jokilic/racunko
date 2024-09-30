import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class RacunkoTheme {
  ///
  /// LIGHT
  ///

  static ThemeData get light {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: lightAppColors.white,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
    );
  }

  static final lightAppColors = RacunkoColorsExtension(
    white: RacunkoColors.white,
    black: RacunkoColors.black,
  );

  static final lightTextTheme = RacunkoTextThemesExtension(
    error: RacunkoTextStyles.error.copyWith(
      color: lightAppColors.black,
    ),
  );
}

extension RacunkoThemeExtension on ThemeData {
  RacunkoColorsExtension get racunkoColors => extension<RacunkoColorsExtension>() ?? RacunkoTheme.lightAppColors;
  RacunkoTextThemesExtension get racunkoTextStyles => extension<RacunkoTextThemesExtension>() ?? RacunkoTheme.lightTextTheme;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  RacunkoColorsExtension get colors => theme.racunkoColors;
  RacunkoTextThemesExtension get textStyles => theme.racunkoTextStyles;
}

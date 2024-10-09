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
    grey: RacunkoColors.grey,
    darkBlue: RacunkoColors.darkBlue,
    blue: RacunkoColors.blue,
    red: RacunkoColors.red,
    green: RacunkoColors.green,
  );

  static final lightTextTheme = RacunkoTextThemesExtension(
    title: RacunkoTextStyles.title.copyWith(
      color: lightAppColors.darkBlue,
    ),
    subtitle: RacunkoTextStyles.subtitle.copyWith(
      color: lightAppColors.darkBlue,
    ),
    button: RacunkoTextStyles.button.copyWith(
      color: lightAppColors.white,
    ),
    text: RacunkoTextStyles.text.copyWith(
      color: lightAppColors.darkBlue,
    ),
    dialogText: RacunkoTextStyles.dialogText.copyWith(
      color: lightAppColors.darkBlue,
    ),
    inputText: RacunkoTextStyles.inputText.copyWith(
      color: lightAppColors.darkBlue,
    ),
    hintText: RacunkoTextStyles.hintText.copyWith(
      color: lightAppColors.darkBlue,
    ),
    fab: RacunkoTextStyles.fab.copyWith(
      color: lightAppColors.white,
    ),
    calendarText: RacunkoTextStyles.calendarText.copyWith(
      color: lightAppColors.darkBlue,
    ),
    invoiceListTileTitle: RacunkoTextStyles.invoiceListTileTitle.copyWith(
      color: lightAppColors.white,
    ),
    invoiceListTileSubtitle: RacunkoTextStyles.invoiceListTileSubtitle.copyWith(
      color: lightAppColors.white,
    ),
    price: RacunkoTextStyles.price.copyWith(
      color: lightAppColors.darkBlue,
    ),
    priceBottom: RacunkoTextStyles.priceBottom.copyWith(
      color: lightAppColors.darkBlue,
    ),
    pdfTitle: RacunkoTextStyles.pdfTitle.copyWith(
      color: lightAppColors.darkBlue,
    ),
    pdfSubtitle: RacunkoTextStyles.pdfSubtitle.copyWith(
      color: lightAppColors.darkBlue,
    ),
    pdfMonthTitle: RacunkoTextStyles.pdfMonthTitle.copyWith(
      color: lightAppColors.darkBlue,
    ),
    pdfBoldText: RacunkoTextStyles.pdfBoldText.copyWith(
      color: lightAppColors.darkBlue,
    ),
    pdfRegularText: RacunkoTextStyles.pdfRegularText.copyWith(
      color: lightAppColors.darkBlue,
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

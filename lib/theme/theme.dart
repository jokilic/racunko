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
      scaffoldBackgroundColor: lightAppColors.background,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
    );
  }

  static final lightAppColors = RacunkoColorsExtension(
    background: RacunkoColors.white,
    disabled: RacunkoColors.grey,
    text: RacunkoColors.darkBlue,
    invertedText: RacunkoColors.white,
    primary: RacunkoColors.blue,
    error: RacunkoColors.red,
    success: RacunkoColors.green,
  );

  static final lightTextTheme = RacunkoTextThemesExtension(
    title: RacunkoTextStyles.title.copyWith(
      color: lightAppColors.text,
    ),
    subtitle: RacunkoTextStyles.subtitle.copyWith(
      color: lightAppColors.text,
    ),
    button: RacunkoTextStyles.button.copyWith(
      color: lightAppColors.invertedText,
    ),
    snackbar: RacunkoTextStyles.snackbar.copyWith(
      color: lightAppColors.text,
    ),
    text: RacunkoTextStyles.text.copyWith(
      color: lightAppColors.text,
    ),
    dialogText: RacunkoTextStyles.dialogText.copyWith(
      color: lightAppColors.text,
    ),
    inputText: RacunkoTextStyles.inputText.copyWith(
      color: lightAppColors.text,
    ),
    hintText: RacunkoTextStyles.hintText.copyWith(
      color: lightAppColors.text,
    ),
    fab: RacunkoTextStyles.fab.copyWith(
      color: lightAppColors.invertedText,
    ),
    calendarText: RacunkoTextStyles.calendarText.copyWith(
      color: lightAppColors.text,
    ),
    invoiceListTileTitle: RacunkoTextStyles.invoiceListTileTitle.copyWith(
      color: lightAppColors.invertedText,
    ),
    invoiceListTileSubtitle: RacunkoTextStyles.invoiceListTileSubtitle.copyWith(
      color: lightAppColors.invertedText,
    ),
    price: RacunkoTextStyles.price.copyWith(
      color: lightAppColors.text,
    ),
    priceBottom: RacunkoTextStyles.priceBottom.copyWith(
      color: lightAppColors.text,
    ),
    pdfTitle: RacunkoTextStyles.pdfTitle.copyWith(
      color: lightAppColors.text,
    ),
    pdfSubtitle: RacunkoTextStyles.pdfSubtitle.copyWith(
      color: lightAppColors.text,
    ),
    pdfMonthTitle: RacunkoTextStyles.pdfMonthTitle.copyWith(
      color: lightAppColors.text,
    ),
    pdfBoldText: RacunkoTextStyles.pdfBoldText.copyWith(
      color: lightAppColors.text,
    ),
    pdfRegularText: RacunkoTextStyles.pdfRegularText.copyWith(
      color: lightAppColors.text,
    ),
  );

  ///
  /// DARK
  ///

  static ThemeData get dark {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      scaffoldBackgroundColor: darkAppColors.background,
      extensions: [
        darkAppColors,
        darkTextTheme,
      ],
    );
  }

  static final darkAppColors = RacunkoColorsExtension(
    background: RacunkoColors.black,
    disabled: RacunkoColors.grey,
    text: RacunkoColors.white,
    invertedText: RacunkoColors.white,
    primary: RacunkoColors.blue,
    error: RacunkoColors.red,
    success: RacunkoColors.green,
  );

  static final darkTextTheme = RacunkoTextThemesExtension(
    title: RacunkoTextStyles.title.copyWith(
      color: darkAppColors.text,
    ),
    subtitle: RacunkoTextStyles.subtitle.copyWith(
      color: darkAppColors.text,
    ),
    button: RacunkoTextStyles.button.copyWith(
      color: darkAppColors.invertedText,
    ),
    snackbar: RacunkoTextStyles.snackbar.copyWith(
      color: darkAppColors.text,
    ),
    text: RacunkoTextStyles.text.copyWith(
      color: darkAppColors.text,
    ),
    dialogText: RacunkoTextStyles.dialogText.copyWith(
      color: darkAppColors.text,
    ),
    inputText: RacunkoTextStyles.inputText.copyWith(
      color: darkAppColors.text,
    ),
    hintText: RacunkoTextStyles.hintText.copyWith(
      color: darkAppColors.text,
    ),
    fab: RacunkoTextStyles.fab.copyWith(
      color: darkAppColors.invertedText,
    ),
    calendarText: RacunkoTextStyles.calendarText.copyWith(
      color: darkAppColors.text,
    ),
    invoiceListTileTitle: RacunkoTextStyles.invoiceListTileTitle.copyWith(
      color: darkAppColors.invertedText,
    ),
    invoiceListTileSubtitle: RacunkoTextStyles.invoiceListTileSubtitle.copyWith(
      color: darkAppColors.invertedText,
    ),
    price: RacunkoTextStyles.price.copyWith(
      color: darkAppColors.text,
    ),
    priceBottom: RacunkoTextStyles.priceBottom.copyWith(
      color: darkAppColors.text,
    ),
    pdfTitle: RacunkoTextStyles.pdfTitle.copyWith(
      color: darkAppColors.text,
    ),
    pdfSubtitle: RacunkoTextStyles.pdfSubtitle.copyWith(
      color: darkAppColors.text,
    ),
    pdfMonthTitle: RacunkoTextStyles.pdfMonthTitle.copyWith(
      color: darkAppColors.text,
    ),
    pdfBoldText: RacunkoTextStyles.pdfBoldText.copyWith(
      color: darkAppColors.text,
    ),
    pdfRegularText: RacunkoTextStyles.pdfRegularText.copyWith(
      color: darkAppColors.text,
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

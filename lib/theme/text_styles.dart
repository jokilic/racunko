import 'package:flutter/material.dart';

abstract class RacunkoTextStyles {
  static const title = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static const subtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const button = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );
  static const snackbar = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );
  static const text = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const dialogText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  static const inputText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const hintText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const fab = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );
  static const calendarText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const invoiceListTileTitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const invoiceListTileSubtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const price = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const priceBottom = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const pdfTitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static const pdfSubtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const pdfMonthTitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const pdfBoldText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const pdfRegularText = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}

class RacunkoTextThemesExtension extends ThemeExtension<RacunkoTextThemesExtension> {
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle button;
  final TextStyle snackbar;
  final TextStyle text;
  final TextStyle dialogText;
  final TextStyle inputText;
  final TextStyle hintText;
  final TextStyle fab;
  final TextStyle calendarText;
  final TextStyle invoiceListTileTitle;
  final TextStyle invoiceListTileSubtitle;
  final TextStyle price;
  final TextStyle priceBottom;
  final TextStyle pdfTitle;
  final TextStyle pdfSubtitle;
  final TextStyle pdfMonthTitle;
  final TextStyle pdfBoldText;
  final TextStyle pdfRegularText;

  const RacunkoTextThemesExtension({
    required this.title,
    required this.subtitle,
    required this.button,
    required this.snackbar,
    required this.text,
    required this.dialogText,
    required this.inputText,
    required this.hintText,
    required this.fab,
    required this.calendarText,
    required this.invoiceListTileTitle,
    required this.invoiceListTileSubtitle,
    required this.price,
    required this.priceBottom,
    required this.pdfTitle,
    required this.pdfSubtitle,
    required this.pdfMonthTitle,
    required this.pdfBoldText,
    required this.pdfRegularText,
  });

  @override
  ThemeExtension<RacunkoTextThemesExtension> copyWith({
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? button,
    TextStyle? snackbar,
    TextStyle? text,
    TextStyle? dialogText,
    TextStyle? inputText,
    TextStyle? hintText,
    TextStyle? fab,
    TextStyle? calendarText,
    TextStyle? invoiceListTileTitle,
    TextStyle? invoiceListTileSubtitle,
    TextStyle? price,
    TextStyle? priceBottom,
    TextStyle? pdfTitle,
    TextStyle? pdfSubtitle,
    TextStyle? pdfMonthTitle,
    TextStyle? pdfBoldText,
    TextStyle? pdfRegularText,
  }) =>
      RacunkoTextThemesExtension(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        button: button ?? this.button,
        snackbar: snackbar ?? this.snackbar,
        text: text ?? this.text,
        dialogText: dialogText ?? this.dialogText,
        inputText: inputText ?? this.inputText,
        hintText: hintText ?? this.hintText,
        fab: fab ?? this.fab,
        calendarText: calendarText ?? this.calendarText,
        invoiceListTileTitle: invoiceListTileTitle ?? this.invoiceListTileTitle,
        invoiceListTileSubtitle: invoiceListTileSubtitle ?? this.invoiceListTileSubtitle,
        price: price ?? this.price,
        priceBottom: priceBottom ?? this.priceBottom,
        pdfTitle: pdfTitle ?? this.pdfTitle,
        pdfSubtitle: pdfSubtitle ?? this.pdfSubtitle,
        pdfMonthTitle: pdfMonthTitle ?? this.pdfMonthTitle,
        pdfBoldText: pdfBoldText ?? this.pdfBoldText,
        pdfRegularText: pdfRegularText ?? this.pdfRegularText,
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
      snackbar: TextStyle.lerp(snackbar, other.snackbar, t)!,
      text: TextStyle.lerp(text, other.text, t)!,
      dialogText: TextStyle.lerp(dialogText, other.dialogText, t)!,
      inputText: TextStyle.lerp(inputText, other.inputText, t)!,
      hintText: TextStyle.lerp(hintText, other.hintText, t)!,
      fab: TextStyle.lerp(fab, other.fab, t)!,
      calendarText: TextStyle.lerp(calendarText, other.calendarText, t)!,
      invoiceListTileTitle: TextStyle.lerp(invoiceListTileTitle, other.invoiceListTileTitle, t)!,
      invoiceListTileSubtitle: TextStyle.lerp(invoiceListTileSubtitle, other.invoiceListTileSubtitle, t)!,
      price: TextStyle.lerp(price, other.price, t)!,
      priceBottom: TextStyle.lerp(priceBottom, other.priceBottom, t)!,
      pdfTitle: TextStyle.lerp(pdfTitle, other.pdfTitle, t)!,
      pdfSubtitle: TextStyle.lerp(pdfSubtitle, other.pdfSubtitle, t)!,
      pdfMonthTitle: TextStyle.lerp(pdfMonthTitle, other.pdfMonthTitle, t)!,
      pdfBoldText: TextStyle.lerp(pdfBoldText, other.pdfBoldText, t)!,
      pdfRegularText: TextStyle.lerp(pdfRegularText, other.pdfRegularText, t)!,
    );
  }
}

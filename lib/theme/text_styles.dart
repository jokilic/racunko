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
  static const invoiceListTileAboveSubtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14,
    fontWeight: FontWeight.w400,
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
}

class RacunkoTextThemesExtension extends ThemeExtension<RacunkoTextThemesExtension> {
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle button;
  final TextStyle text;
  final TextStyle dialogText;
  final TextStyle inputText;
  final TextStyle hintText;
  final TextStyle fab;
  final TextStyle calendarText;
  final TextStyle invoiceListTileTitle;
  final TextStyle invoiceListTileAboveSubtitle;
  final TextStyle invoiceListTileSubtitle;
  final TextStyle price;
  final TextStyle priceBottom;

  const RacunkoTextThemesExtension({
    required this.title,
    required this.subtitle,
    required this.button,
    required this.text,
    required this.dialogText,
    required this.inputText,
    required this.hintText,
    required this.fab,
    required this.calendarText,
    required this.invoiceListTileTitle,
    required this.invoiceListTileAboveSubtitle,
    required this.invoiceListTileSubtitle,
    required this.price,
    required this.priceBottom,
  });

  @override
  ThemeExtension<RacunkoTextThemesExtension> copyWith({
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? button,
    TextStyle? text,
    TextStyle? dialogText,
    TextStyle? inputText,
    TextStyle? hintText,
    TextStyle? fab,
    TextStyle? calendarText,
    TextStyle? invoiceListTileTitle,
    TextStyle? invoiceListTileAboveSubtitle,
    TextStyle? invoiceListTileSubtitle,
    TextStyle? price,
    TextStyle? priceBottom,
  }) =>
      RacunkoTextThemesExtension(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        button: button ?? this.button,
        text: text ?? this.text,
        dialogText: dialogText ?? this.dialogText,
        inputText: inputText ?? this.inputText,
        hintText: hintText ?? this.hintText,
        fab: fab ?? this.fab,
        calendarText: calendarText ?? this.calendarText,
        invoiceListTileTitle: invoiceListTileTitle ?? this.invoiceListTileTitle,
        invoiceListTileAboveSubtitle: invoiceListTileAboveSubtitle ?? this.invoiceListTileAboveSubtitle,
        invoiceListTileSubtitle: invoiceListTileSubtitle ?? this.invoiceListTileSubtitle,
        price: price ?? this.price,
        priceBottom: priceBottom ?? this.priceBottom,
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
      dialogText: TextStyle.lerp(dialogText, other.dialogText, t)!,
      inputText: TextStyle.lerp(inputText, other.inputText, t)!,
      hintText: TextStyle.lerp(hintText, other.hintText, t)!,
      fab: TextStyle.lerp(fab, other.fab, t)!,
      calendarText: TextStyle.lerp(calendarText, other.calendarText, t)!,
      invoiceListTileTitle: TextStyle.lerp(invoiceListTileTitle, other.invoiceListTileTitle, t)!,
      invoiceListTileAboveSubtitle: TextStyle.lerp(invoiceListTileAboveSubtitle, other.invoiceListTileAboveSubtitle, t)!,
      invoiceListTileSubtitle: TextStyle.lerp(invoiceListTileSubtitle, other.invoiceListTileSubtitle, t)!,
      price: TextStyle.lerp(price, other.price, t)!,
      priceBottom: TextStyle.lerp(priceBottom, other.priceBottom, t)!,
    );
  }
}

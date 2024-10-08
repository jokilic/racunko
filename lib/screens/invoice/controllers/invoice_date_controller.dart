import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../services/logger_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';

class InvoiceDateController extends ValueNotifier<({DateTime? monthFrom, DateTime? monthTo})> {
  final LoggerService logger;
  final Invoice? invoiceToEdit;

  InvoiceDateController({
    required this.logger,
    this.invoiceToEdit,
  }) : super((monthFrom: null, monthTo: null));

  ///
  /// METHODS
  ///

  /// Updates state to the dates of `invoiceToEdit`, if it exists
  void fillCalendarIfPossible() {
    if (invoiceToEdit != null) {
      value = (
        monthFrom: invoiceToEdit!.monthFrom,
        monthTo: invoiceToEdit!.monthTo,
      );
    }
  }

  /// Triggered when the user taps the date icon
  /// Opens calendar and stores the picked dates in `state`
  Future<void> openCalendar(BuildContext context) async {
    final chosenDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        calendarType: CalendarDatePicker2Type.range,
        weekdayLabelTextStyle: context.textStyles.calendarText.copyWith(
          fontSize: 16,
        ),
        controlsTextStyle: context.textStyles.calendarText,
        dayTextStyle: context.textStyles.calendarText,
        todayTextStyle: context.textStyles.calendarText,
        selectedDayTextStyle: context.textStyles.calendarText.copyWith(
          color: context.colors.white,
        ),
        selectedMonthTextStyle: context.textStyles.calendarText.copyWith(
          color: context.colors.white,
        ),
        selectedYearTextStyle: context.textStyles.calendarText.copyWith(
          color: context.colors.white,
        ),
        selectedDayHighlightColor: context.colors.darkBlue,
        daySplashColor: context.colors.darkBlue,
        firstDayOfWeek: 1,
        cancelButton: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            foregroundColor: context.colors.darkBlue,
            textStyle: context.textStyles.button,
          ),
          child: Text(
            'Odustani'.toUpperCase(),
            style: context.textStyles.text,
          ),
        ),
        okButton: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            foregroundColor: context.colors.darkBlue,
            textStyle: context.textStyles.button,
          ),
          child: Text(
            'Prihvati'.toUpperCase(),
            style: context.textStyles.text,
          ),
        ),
        lastMonthIcon: Image.asset(
          RacunkoIcons.back,
          height: 20,
          width: 20,
        ),
        nextMonthIcon: Transform.rotate(
          angle: pi,
          child: Image.asset(
            RacunkoIcons.back,
            height: 20,
            width: 20,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: context.colors.white,
      dialogSize: const Size(400, 432),
    );

    if (chosenDates?.isNotEmpty ?? false) {
      final firstDate = chosenDates?.firstOrNull;
      final lastDate = chosenDates?.lastOrNull;

      if (firstDate != null && lastDate != null) {
        value = (
          monthFrom: firstDate,
          monthTo: lastDate,
        );
      }
    }
  }
}

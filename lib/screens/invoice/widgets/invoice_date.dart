import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';

class InvoiceDate extends StatelessWidget {
  final Function(BuildContext context) onCalendarPressed;
  final ({DateTime? monthFrom, DateTime? monthTo}) dates;

  const InvoiceDate({
    required this.onCalendarPressed,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = dates.monthFrom != null && dates.monthTo != null
        ? '${DateFormat(
            'd. MMMM y.',
            'hr',
          ).format(dates.monthFrom!)}\n${DateFormat(
            'd. MMMM y.',
            'hr',
          ).format(dates.monthTo!)}'
        : 'Odaberi mjesec';

    return Column(
      children: [
        ///
        /// ELECTRICITY
        ///
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Mjesec',
            style: context.textStyles.subtitle,
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => onCalendarPressed(context),
          icon: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Image.asset(
              RacunkoIcons.calendar,
              height: 28,
              width: 28,
              color: context.colors.darkBlue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(
              color: context.colors.darkBlue,
              width: 2.5,
            ),
            iconColor: context.colors.darkBlue,
            backgroundColor: context.colors.white,
            foregroundColor: context.colors.darkBlue,
            overlayColor: context.colors.darkBlue,
            textStyle: context.textStyles.button.copyWith(
              height: 1.6,
            ),
          ),
          label: Text(buttonText),
        ),
      ],
    );
  }
}

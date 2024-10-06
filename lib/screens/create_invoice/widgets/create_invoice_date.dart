import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';

class CreateInvoiceDate extends StatelessWidget {
  final Function(BuildContext context) onCalendarPressed;
  final ({DateTime? monthFrom, DateTime? monthTo}) dates;

  const CreateInvoiceDate({
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
          icon: const Icon(
            Icons.calendar_month,
            size: 28,
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
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

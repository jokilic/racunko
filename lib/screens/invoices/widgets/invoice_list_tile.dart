import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/invoice.dart';
import '../../../theme/theme.dart';

class InvoiceListTile extends StatelessWidget {
  final Invoice invoice;
  final Function() onPressed;

  const InvoiceListTile({
    required this.invoice,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        tileColor: context.colors.darkBlue,
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: context.textStyles.invoiceListTileTitle,
        subtitleTextStyle: context.textStyles.invoiceListTileSubtitle,
        leadingAndTrailingTextStyle: context.textStyles.invoiceListTileTitle,
        splashColor: Colors.transparent,
        iconColor: context.colors.white,
        onTap: onPressed,
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(invoice.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Mjesec',
              style: context.textStyles.invoiceListTileAboveSubtitle,
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat(
                'd. MMMM y.',
                'hr',
              ).format(invoice.monthFrom),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat(
                'd. MMMM y.',
                'hr',
              ).format(invoice.monthTo),
            ),
          ],
        ),
        trailing: Column(
          children: [
            const Icon(Icons.euro),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                invoice.totalPrice.toStringAsFixed(2),
              ),
            ),
          ],
        ),
      );
}

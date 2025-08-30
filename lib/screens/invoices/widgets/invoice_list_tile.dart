import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';

import '../../../models/invoice.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';

class InvoiceListTile extends StatelessWidget {
  final Invoice invoice;
  final Function() onPressed;
  final Function() deletePressed;
  final Function() generatePdfPressed;

  const InvoiceListTile({
    required this.invoice,
    required this.onPressed,
    required this.deletePressed,
    required this.generatePdfPressed,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: SwipeActionCell(
      key: ValueKey(invoice),
      backgroundColor: context.colors.primary,
      openAnimationCurve: Curves.easeIn,
      closeAnimationCurve: Curves.easeIn,
      leadingActions: [
        SwipeAction(
          onTap: (handler) async {
            await handler(false);
            await deletePressed();
          },
          color: context.colors.error,
          backgroundRadius: 16,
          icon: Image.asset(
            RacunkoIcons.delete,
            color: context.colors.invertedText,
            height: 40,
            width: 40,
          ),
        ),
      ],
      trailingActions: [
        SwipeAction(
          onTap: (handler) {
            handler(false);
            generatePdfPressed();
          },
          color: context.colors.success,
          backgroundRadius: 16,
          icon: Image.asset(
            RacunkoIcons.pdf,
            color: context.colors.invertedText,
            height: 32,
            width: 32,
          ),
        ),
      ],
      child: ListTile(
        tileColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconColor: context.colors.invertedText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: context.textStyles.invoiceListTileTitle,
        subtitleTextStyle: context.textStyles.invoiceListTileSubtitle,
        leadingAndTrailingTextStyle: context.textStyles.invoiceListTileTitle,
        onTap: onPressed,
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(invoice.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
            Image.asset(
              RacunkoIcons.euro,
              color: context.colors.invertedText,
              height: 16,
              width: 16,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                invoice.totalPrice.toStringAsFixed(2),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class InvoiceDeleteDialog extends StatelessWidget {
  final String text;
  final Function() cancelPressed;
  final Function() deletePressed;

  const InvoiceDeleteDialog({
    required this.text,
    required this.cancelPressed,
    required this.deletePressed,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Text(
          text,
          style: context.textStyles.dialogText,
        ),
        actions: [
          TextButton(
            onPressed: deletePressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              foregroundColor: context.colors.text,
              textStyle: context.textStyles.button,
            ),
            child: Text(
              'Da'.toUpperCase(),
              style: context.textStyles.text,
            ),
          ),
          TextButton(
            onPressed: cancelPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              foregroundColor: context.colors.text,
              textStyle: context.textStyles.button,
            ),
            child: Text(
              'Ne'.toUpperCase(),
              style: context.textStyles.text,
            ),
          ),
        ],
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
        actionsPadding: const EdgeInsets.all(8),
        backgroundColor: context.colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colors.text,
            width: 2.5,
          ),
        ),
      );
}

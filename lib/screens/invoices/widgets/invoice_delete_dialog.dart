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
              foregroundColor: context.colors.darkBlue,
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
              foregroundColor: context.colors.darkBlue,
              textStyle: context.textStyles.button,
            ),
            child: Text(
              'Ne'.toUpperCase(),
              style: context.textStyles.text,
            ),
          ),
        ],
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
        actionsPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        backgroundColor: context.colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colors.darkBlue,
            width: 2.5,
          ),
        ),
      );
}

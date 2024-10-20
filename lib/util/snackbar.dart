import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';

void showSnackbar(
  BuildContext context, {
  required String text,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: context.colors.background,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2.5,
        ),
      ),
      content: Row(
        children: [
          Image.asset(
            RacunkoIcons.invoice,
            height: 30,
            width: 30,
            color: context.colors.text,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.textStyles.snackbar,
            ),
          ),
        ],
      ),
    ),
  );
}

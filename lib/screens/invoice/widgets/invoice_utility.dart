import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_text_field.dart';

class InvoiceUtility extends StatelessWidget {
  final TextEditingController utilityController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const InvoiceUtility({
    required this.utilityController,
    required this.onTextFieldChanged,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Komunalna naknada',
                style: context.textStyles.subtitle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RacunkoTextField(
              textController: utilityController,
              hintText: fees?.utility.toStringAsFixed(2),
              onChanged: (_) => onTextFieldChanged(),
            ),
          ),
        ],
      );
}

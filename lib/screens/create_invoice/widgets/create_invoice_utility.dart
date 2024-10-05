import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceUtility extends StatelessWidget {
  final TextEditingController utilityController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const CreateInvoiceUtility({
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
            child: RacunkoNumberField(
              textController: utilityController,
              hintText: fees?.utility.toString() ?? '---',
              onChanged: (_) => onTextFieldChanged(),
            ),
          ),
        ],
      );
}

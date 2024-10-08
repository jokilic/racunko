import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_text_field.dart';

class InvoiceReserve extends StatelessWidget {
  final TextEditingController reserveController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const InvoiceReserve({
    required this.reserveController,
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
                'Pričuva',
                style: context.textStyles.subtitle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RacunkoTextField(
              textController: reserveController,
              hintText: fees?.reserve.toStringAsFixed(2),
              onChanged: (_) => onTextFieldChanged(),
            ),
          ),
        ],
      );
}

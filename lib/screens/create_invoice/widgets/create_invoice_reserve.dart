import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceReserve extends StatelessWidget {
  final TextEditingController reserveController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const CreateInvoiceReserve({
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
            child: RacunkoNumberField(
              textController: reserveController,
              hintText: fees?.reserve.toString() ?? '---',
              onChanged: (_) => onTextFieldChanged(),
            ),
          ),
        ],
      );
}

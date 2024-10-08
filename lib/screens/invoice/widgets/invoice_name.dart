import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/racunko_text_field.dart';

class InvoiceName extends StatelessWidget {
  final TextEditingController nameController;
  final Function() onTextFieldChanged;

  const InvoiceName({
    required this.nameController,
    required this.onTextFieldChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Naziv',
                style: context.textStyles.subtitle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RacunkoTextField(
              textController: nameController,
              hintText: 'Naziv',
              onChanged: (_) => onTextFieldChanged(),
              isCurrency: false,
              verticalPadding: 16,
            ),
          ),
        ],
      );
}

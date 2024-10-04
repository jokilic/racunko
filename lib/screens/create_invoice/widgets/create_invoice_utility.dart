import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceUtility extends StatelessWidget {
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
              hintText: '11.31€',
              onChanged: (value) {},
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceReserve extends StatelessWidget {
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
              hintText: '21.92€',
              onChanged: (value) {},
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceConsumption extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Brojila',
                style: context.textStyles.subtitle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Plin',
                    style: context.textStyles.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Prošli mjesec',
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Novi mjesec',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Struja',
                    style: context.textStyles.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Prošli mjesec',
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Novi mjesec',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Voda',
                    style: context.textStyles.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Prošli mjesec',
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    hintText: 'Novi mjesec',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

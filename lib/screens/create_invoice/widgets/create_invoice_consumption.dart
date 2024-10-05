import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceConsumption extends StatelessWidget {
  final TextEditingController electricityHigherLastMonthController;
  final TextEditingController electricityHigherNewMonthController;
  final TextEditingController electricityLowerLastMonthController;
  final TextEditingController electricityLowerNewMonthController;
  final TextEditingController gasLastMonthController;
  final TextEditingController gasNewMonthController;
  final TextEditingController waterLastMonthController;
  final TextEditingController waterNewMonthController;
  final Function() onTextFieldChanged;

  const CreateInvoiceConsumption({
    required this.electricityHigherLastMonthController,
    required this.electricityHigherNewMonthController,
    required this.electricityLowerLastMonthController,
    required this.electricityLowerNewMonthController,
    required this.gasLastMonthController,
    required this.gasNewMonthController,
    required this.waterLastMonthController,
    required this.waterNewMonthController,
    required this.onTextFieldChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// ELECTRICITY
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Struja',
              style: context.textStyles.subtitle,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Viša tarifa',
                style: context.textStyles.text,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: electricityHigherLastMonthController,
                    hintText: 'Prošli mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: electricityHigherNewMonthController,
                    hintText: 'Novi mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Niža tarifa',
                style: context.textStyles.text,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: electricityLowerLastMonthController,
                    hintText: 'Prošli mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: electricityLowerNewMonthController,
                    hintText: 'Novi mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          ///
          /// GAS
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Plin',
              style: context.textStyles.subtitle,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: RacunkoNumberField(
                    textController: gasLastMonthController,
                    hintText: 'Prošli mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RacunkoNumberField(
                    textController: gasNewMonthController,
                    hintText: 'Novi mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          ///
          /// WATER
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Voda',
              style: context.textStyles.subtitle,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: waterLastMonthController,
                    hintText: 'Prošli mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RacunkoNumberField(
                    textController: waterNewMonthController,
                    hintText: 'Novi mjesec',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_number_field.dart';

class CreateInvoiceFees extends StatelessWidget {
  final TextEditingController feesGasController;
  final TextEditingController feesElectricityController;
  final TextEditingController feesWaterController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const CreateInvoiceFees({
    required this.feesGasController,
    required this.feesElectricityController,
    required this.feesWaterController,
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
                'Naknade',
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
                    'Struja',
                    style: context.textStyles.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: RacunkoNumberField(
                    textController: feesElectricityController,
                    hintText: fees?.feesElectricity.toString() ?? '---',
                    onChanged: (_) => onTextFieldChanged(),
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
                    'Plin',
                    style: context.textStyles.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: RacunkoNumberField(
                    textController: feesGasController,
                    hintText: fees?.feesGas.toString() ?? '---',
                    onChanged: (_) => onTextFieldChanged(),
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
                  flex: 4,
                  child: RacunkoNumberField(
                    textController: feesWaterController,
                    hintText: fees?.feesWater.toString() ?? '---',
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

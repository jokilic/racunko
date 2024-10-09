import 'package:flutter/material.dart';

import '../../../models/fees.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_text_field.dart';

class InvoiceFees extends StatelessWidget {
  final TextEditingController feesGasController;
  final TextEditingController feesElectricityController;
  final TextEditingController feesWaterController;
  final Function() onTextFieldChanged;
  final Fees? fees;

  const InvoiceFees({
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
                  child: RacunkoTextField(
                    textController: feesElectricityController,
                    hintText: fees?.feesElectricity.toStringAsFixed(2),
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
                  child: RacunkoTextField(
                    textController: feesGasController,
                    hintText: fees?.feesGas.toStringAsFixed(2),
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
                  child: RacunkoTextField(
                    textController: feesWaterController,
                    hintText: fees?.feesWater.toStringAsFixed(2),
                    onChanged: (_) => onTextFieldChanged(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

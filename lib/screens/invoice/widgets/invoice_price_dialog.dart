import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/prices.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/racunko_text_field.dart';

class InvoicePriceDialog extends StatefulWidget {
  final Prices prices;
  final Function() cancelPressed;
  final Function(Prices newPrices) savePressed;

  const InvoicePriceDialog({
    required this.prices,
    required this.cancelPressed,
    required this.savePressed,
  });

  @override
  State<InvoicePriceDialog> createState() => _InvoicePriceDialogState();
}

class _InvoicePriceDialogState extends State<InvoicePriceDialog> {
  final electricityHigherPriceController = TextEditingController();
  final electricityLowerPriceController = TextEditingController();
  final gasPriceController = TextEditingController();
  final waterPriceController = TextEditingController();

  @override
  void dispose() {
    electricityHigherPriceController.dispose();
    electricityLowerPriceController.dispose();
    gasPriceController.dispose();
    waterPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Cijene',
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
                    child: Row(
                      children: [
                        Text(
                          'Struja',
                          style: context.textStyles.text,
                        ),
                        const SizedBox(width: 8),
                        Transform.rotate(
                          angle: pi / 2,
                          child: Image.asset(
                            RacunkoIcons.back,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: RacunkoTextField(
                      textController: electricityHigherPriceController,
                      hintText: widget.prices.electricityHigherPrice.toStringAsFixed(2),
                      onChanged: (_) {},
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
                    child: Row(
                      children: [
                        Text(
                          'Struja',
                          style: context.textStyles.text,
                        ),
                        const SizedBox(width: 8),
                        Transform.rotate(
                          angle: pi * 1.5,
                          child: Image.asset(
                            RacunkoIcons.back,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: RacunkoTextField(
                      textController: electricityLowerPriceController,
                      hintText: widget.prices.electricityLowerPrice.toStringAsFixed(2),
                      onChanged: (_) {},
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
                    flex: 2,
                    child: RacunkoTextField(
                      textController: gasPriceController,
                      hintText: widget.prices.gasPrice.toStringAsFixed(2),
                      onChanged: (_) {},
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
                    child: RacunkoTextField(
                      textController: waterPriceController,
                      hintText: widget.prices.waterPrice.toStringAsFixed(2),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: widget.cancelPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              foregroundColor: context.colors.darkBlue,
              textStyle: context.textStyles.button,
            ),
            child: Text(
              'Odustani'.toUpperCase(),
              style: context.textStyles.text,
            ),
          ),
          TextButton(
            onPressed: () {
              final electricityHigherPrice = double.tryParse(electricityHigherPriceController.text.trim()) ?? widget.prices.electricityHigherPrice;
              final electricityLowerPrice = double.tryParse(electricityLowerPriceController.text.trim()) ?? widget.prices.electricityLowerPrice;
              final gasPrice = double.tryParse(gasPriceController.text.trim()) ?? widget.prices.gasPrice;
              final waterPrice = double.tryParse(waterPriceController.text.trim()) ?? widget.prices.waterPrice;

              widget.savePressed(
                Prices(
                  electricityHigherPrice: electricityHigherPrice,
                  electricityLowerPrice: electricityLowerPrice,
                  gasPrice: gasPrice,
                  waterPrice: waterPrice,
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              foregroundColor: context.colors.darkBlue,
              textStyle: context.textStyles.button,
            ),
            child: Text(
              'Ok'.toUpperCase(),
              style: context.textStyles.text,
            ),
          ),
        ],
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
        actionsPadding: const EdgeInsets.all(8),
        backgroundColor: context.colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colors.darkBlue,
            width: 2.5,
          ),
        ),
      );
}

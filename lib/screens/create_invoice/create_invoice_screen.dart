import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'widgets/create_invoice_consumption.dart';
import 'widgets/create_invoice_fees.dart';
import 'widgets/create_invoice_reserve.dart';
import 'widgets/create_invoice_utility.dart';

class CreateInvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              24,
              16,
              MediaQuery.paddingOf(context).bottom + 24,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Novi račun 🧾',
                  style: context.textStyles.title,
                ),
              ),
              const SizedBox(height: 32),
              CreateInvoiceConsumption(),
              const SizedBox(height: 40),
              CreateInvoiceFees(),
              const SizedBox(height: 40),
              CreateInvoiceUtility(),
              const SizedBox(height: 40),
              CreateInvoiceReserve(),
              const SizedBox(height: 72),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.receipt_long,
                  size: 28,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  iconColor: context.colors.white,
                  backgroundColor: context.colors.darkBlue,
                  textStyle: context.textStyles.button,
                  foregroundColor: context.colors.white,
                ),
                label: const Text('Napravi račun'),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../models/invoice.dart';
import '../../routing.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../theme/theme.dart';
import 'create_invoice_controller.dart';
import 'widgets/create_invoice_consumption.dart';
import 'widgets/create_invoice_fees.dart';
import 'widgets/create_invoice_reserve.dart';
import 'widgets/create_invoice_utility.dart';

class CreateInvoiceScreen extends WatchingStatefulWidget {
  final Invoice? previousInvoice;

  const CreateInvoiceScreen({
    required this.previousInvoice,
  });

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<CreateInvoiceController>(
      () => CreateInvoiceController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      ),
      afterRegister: (controller) => controller.fillTextControllers(),
    );
  }

  @override
  void dispose() {
    getIt.unregister<CreateInvoiceController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<CreateInvoiceController>();
    final fees = getIt.get<HiveService>().getFees();
    final totalPrice = watchIt<CreateInvoiceController>().value?.totalPrice;

    return Scaffold(
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
            CreateInvoiceConsumption(
              electricityHigherLastMonthController: controller.electricityHigherLastMonthController,
              electricityHigherNewMonthController: controller.electricityHigherNewMonthController,
              electricityLowerLastMonthController: controller.electricityLowerLastMonthController,
              electricityLowerNewMonthController: controller.electricityLowerNewMonthController,
              gasLastMonthController: controller.gasLastMonthController,
              gasNewMonthController: controller.gasNewMonthController,
              waterLastMonthController: controller.waterLastMonthController,
              waterNewMonthController: controller.waterNewMonthController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
            ),
            const SizedBox(height: 40),
            CreateInvoiceFees(
              feesGasController: controller.feesGasController,
              feesElectricityController: controller.feesElectricityController,
              feesWaterController: controller.feesWaterController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 40),
            CreateInvoiceUtility(
              utilityController: controller.utilityController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 40),
            CreateInvoiceReserve(
              reserveController: controller.reserveController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 72),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ukupno',
                      style: context.textStyles.text,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: Text(
                      totalPrice != null ? '$totalPrice €' : '---',
                      style: context.textStyles.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final newInvoice = controller.createInvoice();

                if (newInvoice != null) {
                  openInvoiceCreated(
                    context,
                    invoice: newInvoice,
                  );
                }
              },
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
                foregroundColor: context.colors.white,
                textStyle: context.textStyles.button,
              ),
              label: const Text('Napravi račun'),
            ),
          ],
        ),
      ),
    );
  }
}

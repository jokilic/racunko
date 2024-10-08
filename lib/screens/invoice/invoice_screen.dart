import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../models/invoice.dart';
import '../../services/firebase_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../theme/icons.dart';
import '../../theme/theme.dart';
import 'controllers/invoice_controller.dart';
import 'controllers/invoice_date_controller.dart';
import 'widgets/invoice_consumption.dart';
import 'widgets/invoice_date.dart';
import 'widgets/invoice_fees.dart';
import 'widgets/invoice_name.dart';
import 'widgets/invoice_price_dialog.dart';
import 'widgets/invoice_reserve.dart';
import 'widgets/invoice_utility.dart';

class InvoiceScreen extends WatchingStatefulWidget {
  final Invoice? lastInvoice;
  final Invoice? invoiceToEdit;

  const InvoiceScreen({
    this.lastInvoice,
    this.invoiceToEdit,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<InvoiceDateController>(
      () => InvoiceDateController(
        logger: getIt.get<LoggerService>(),
        invoiceToEdit: widget.invoiceToEdit,
      ),
      afterRegister: (controller) => controller.fillCalendarIfPossible(),
    );
    registerIfNotInitialized<InvoiceController>(
      () => InvoiceController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        firebase: getIt.get<FirebaseService>(),
        dateController: getIt.get<InvoiceDateController>(),
        lastInvoice: widget.lastInvoice,
        invoiceToEdit: widget.invoiceToEdit,
      ),
      afterRegister: (controller) => controller.fillTextControllers(),
    );
  }

  @override
  void dispose() {
    getIt
      ..unregister<InvoiceDateController>()
      ..unregister<InvoiceController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<InvoiceController>();
    final controllerDate = getIt.get<InvoiceDateController>();

    final fees = getIt.get<HiveService>().getFees();

    final invoice = watchIt<InvoiceController>().value;
    final dates = watchIt<InvoiceDateController>().value;

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
            ///
            /// APP BAR
            ///
            Row(
              children: [
                IconButton.filled(
                  onPressed: Navigator.of(context).pop,
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: context.colors.white,
                    foregroundColor: context.colors.darkBlue,
                    overlayColor: context.colors.darkBlue,
                  ),
                  icon: Image.asset(
                    RacunkoIcons.back,
                    color: context.colors.darkBlue,
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.invoiceToEdit != null ? 'Uredi račun 🧾' : 'Novi račun 🧾',
                    style: context.textStyles.title,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            ///
            /// NAME
            ///
            InvoiceName(
              nameController: controller.nameController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
            ),
            const SizedBox(height: 32),

            ///
            /// DATE
            ///
            InvoiceDate(
              onCalendarPressed: (context) async {
                await controllerDate.openCalendar(context);
                controller.generateInvoiceFromTextFields();
              },
              dates: dates,
            ),
            const SizedBox(height: 32),

            ///
            /// CONSUMPTION
            ///
            InvoiceConsumption(
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
            const SizedBox(height: 32),

            ///
            /// FEES
            ///
            InvoiceFees(
              feesGasController: controller.feesGasController,
              feesElectricityController: controller.feesElectricityController,
              feesWaterController: controller.feesWaterController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 32),

            ///
            /// UTILITY
            ///
            InvoiceUtility(
              utilityController: controller.utilityController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 32),

            ///
            /// RESERVE
            ///
            InvoiceReserve(
              reserveController: controller.reserveController,
              onTextFieldChanged: controller.generateInvoiceFromTextFields,
              fees: fees,
            ),
            const SizedBox(height: 72),

            ///
            /// TOTAL
            ///
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
                      invoice?.totalPrice != null ? '${invoice?.totalPrice.toStringAsFixed(2)} €' : '---',
                      style: context.textStyles.subtitle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ///
            /// PRICES
            ///
            OutlinedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => InvoicePriceDialog(
                  prices: getIt.get<HiveService>().getPrices(),
                  cancelPressed: Navigator.of(context).pop,
                  savePressed: (newPrices) async {
                    Navigator.of(context).pop();
                    await getIt.get<HiveService>().addNewPrices(newPrices);
                    controller.generateInvoiceFromTextFields();
                  },
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  RacunkoIcons.prices,
                  height: 24,
                  width: 24,
                  color: context.colors.darkBlue,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: context.colors.darkBlue,
                  width: 2.5,
                ),
                backgroundColor: context.colors.white,
                foregroundColor: context.colors.darkBlue,
                overlayColor: context.colors.darkBlue,
                textStyle: context.textStyles.button,
              ),
              label: const Text('Cijene energenata'),
            ),
            const SizedBox(height: 16),

            ///
            /// CREATE INVOICE
            ///
            ElevatedButton.icon(
              onPressed: invoice != null
                  ? () async {
                      final newInvoice = await controller.createInvoice();

                      if (newInvoice != null) {
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              icon: Image.asset(
                RacunkoIcons.invoice,
                height: 28,
                width: 28,
                color: context.colors.white,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: context.colors.green,
                foregroundColor: context.colors.white,
                overlayColor: context.colors.white,
                disabledBackgroundColor: context.colors.grey,
                disabledForegroundColor: context.colors.white,
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

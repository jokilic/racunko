import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../../models/fees.dart';
import '../../../models/invoice.dart';
import '../../../services/hive_service.dart';
import '../../../services/logger_service.dart';
import 'invoice_date_controller.dart';

class InvoiceController extends ValueNotifier<Invoice?> implements Disposable {
  final LoggerService logger;
  final HiveService hive;
  final InvoiceDateController dateController;
  final Invoice? invoiceToEdit;

  InvoiceController({
    required this.logger,
    required this.hive,
    required this.dateController,
    this.invoiceToEdit,
  }) : super(null);

  ///
  /// VARIABLES
  ///

  final nameController = TextEditingController();

  final electricityHigherLastMonthController = TextEditingController();
  final electricityHigherNewMonthController = TextEditingController();

  final electricityLowerLastMonthController = TextEditingController();
  final electricityLowerNewMonthController = TextEditingController();

  final gasLastMonthController = TextEditingController();
  final gasNewMonthController = TextEditingController();

  final waterLastMonthController = TextEditingController();
  final waterNewMonthController = TextEditingController();

  final feesElectricityController = TextEditingController();
  final feesGasController = TextEditingController();
  final feesWaterController = TextEditingController();

  final utilityController = TextEditingController();
  final reserveController = TextEditingController();

  late final uuid = const Uuid();

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    nameController.dispose();
    electricityHigherLastMonthController.dispose();
    electricityHigherNewMonthController.dispose();
    electricityLowerLastMonthController.dispose();
    electricityLowerNewMonthController.dispose();
    gasLastMonthController.dispose();
    gasNewMonthController.dispose();
    waterLastMonthController.dispose();
    waterNewMonthController.dispose();
    feesElectricityController.dispose();
    feesGasController.dispose();
    feesWaterController.dispose();
    utilityController.dispose();
    reserveController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Checks if there are values in storage or passed into the controller
  /// Fills relevant [TextEditingController] with proper value
  void fillTextControllers() {
    final lastInvoice = hive.getLastInvoice();
    final fees = hive.getFees();

    /// User editing invoice, fill all controlles with values
    if (invoiceToEdit != null) {
      nameController.text = invoiceToEdit!.name;

      electricityHigherLastMonthController.text = invoiceToEdit!.electricityHigherLastMonth.toInt().toString();
      electricityHigherNewMonthController.text = invoiceToEdit!.electricityHigherNewMonth.toInt().toString();
      electricityLowerLastMonthController.text = invoiceToEdit!.electricityLowerLastMonth.toInt().toString();
      electricityLowerNewMonthController.text = invoiceToEdit!.electricityLowerNewMonth.toInt().toString();

      gasLastMonthController.text = invoiceToEdit!.gasLastMonth.toInt().toString();
      gasNewMonthController.text = invoiceToEdit!.gasNewMonth.toInt().toString();

      waterLastMonthController.text = invoiceToEdit!.waterLastMonth.toInt().toString();
      waterNewMonthController.text = invoiceToEdit!.waterNewMonth.toInt().toString();
    }

    /// User is creating a new invoice and last invoice exists
    else if (lastInvoice != null) {
      nameController.text = lastInvoice.name;

      electricityHigherLastMonthController.text = lastInvoice.electricityHigherNewMonth.toInt().toString();
      electricityLowerLastMonthController.text = lastInvoice.electricityLowerNewMonth.toInt().toString();

      gasLastMonthController.text = lastInvoice.gasNewMonth.toInt().toString();

      waterLastMonthController.text = lastInvoice.waterNewMonth.toInt().toString();
    }

    if (fees != null) {
      feesElectricityController.text = fees.feesElectricity.toStringAsFixed(2);
      feesGasController.text = fees.feesGas.toStringAsFixed(2);
      feesWaterController.text = fees.feesWater.toStringAsFixed(2);
      utilityController.text = fees.utility.toStringAsFixed(2);
      reserveController.text = fees.reserve.toStringAsFixed(2);
    }
  }

  /// Triggered when `Create invoice` is pressed
  /// Generates new invoice
  /// Stores new fees in storage if necessary
  Future<Invoice?> createInvoice() async {
    /// Generate new invoice
    final newInvoice = generateInvoiceFromTextFields();

    if (newInvoice != null) {
      /// Compare fees
      final oldFees = hive.getFees();
      final newFees = newInvoice.fees;

      /// If the fees are not the same, add new values in storage
      if (oldFees != newFees) {
        await hive.addNewFees(newFees);
        logger.d('New fees in storage');
      }

      /// Edit passed invoice
      if (invoiceToEdit != null) {
        await hive.replaceInvoice(
          editedInvoiceId: invoiceToEdit!.id,
          newInvoice: newInvoice,
        );
      }

      /// Create new invoice
      else {
        await hive.addNewInvoice(newInvoice);
      }

      logger.d('Invoice created');
      return newInvoice;
    }

    return null;
  }

  /// Triggered on every [TextField] change
  /// Calculates invoice and updates `state`
  /// Sets `state` to `null` if some of the values are missing or unable to parse
  Invoice? generateInvoiceFromTextFields() {
    ///
    /// Parse all values to `double`
    ///

    /// Electricity higher
    final electricityHigherLastMonth = double.tryParse(electricityHigherLastMonthController.text.trim());
    final electricityHigherNewMonth = double.tryParse(electricityHigherNewMonthController.text.trim());

    /// Electricity lower
    final electricityLowerLastMonth = double.tryParse(electricityLowerLastMonthController.text.trim());
    final electricityLowerNewMonth = double.tryParse(electricityLowerNewMonthController.text.trim());

    /// Gas
    final gasLastMonth = double.tryParse(gasLastMonthController.text.trim());
    final gasNewMonth = double.tryParse(gasNewMonthController.text.trim());

    /// Water
    final waterLastMonth = double.tryParse(waterLastMonthController.text.trim());
    final waterNewMonth = double.tryParse(waterNewMonthController.text.trim());

    /// Fees
    final feesElectricity = double.tryParse(feesElectricityController.text.trim());
    final feesGas = double.tryParse(feesGasController.text.trim());
    final feesWater = double.tryParse(feesWaterController.text.trim());

    /// Utility
    final utility = double.tryParse(utilityController.text.trim());

    /// Reserve
    final reserve = double.tryParse(reserveController.text.trim());

    /// Don't calculate if name isn't filled
    if (nameController.text.trim().isEmpty) {
      logger.e("Name isn't filled");
      value = null;
      return null;
    }

    ///
    /// Don't calculate if any of the values is `null`
    ///
    if (electricityHigherLastMonth == null ||
        electricityHigherNewMonth == null ||
        electricityLowerLastMonth == null ||
        electricityLowerNewMonth == null ||
        gasLastMonth == null ||
        gasNewMonth == null ||
        waterLastMonth == null ||
        waterNewMonth == null ||
        feesGas == null ||
        feesElectricity == null ||
        feesWater == null ||
        utility == null ||
        reserve == null) {
      logger.e('Some of the values is null');
      value = null;
      return null;
    }

    /// Don't calculate if any of the last month values are higher or same as any of the new month values
    if ((electricityHigherLastMonth >= electricityHigherNewMonth) ||
        (electricityLowerLastMonth >= electricityLowerNewMonth) ||
        (gasLastMonth >= gasNewMonth) ||
        (waterLastMonth >= waterNewMonth)) {
      logger.e('Some of the last month values are higher or same as some of the new month values');
      value = null;
      return null;
    }

    /// Don't calculate if the date isn't picked out
    if (dateController.value.monthFrom == null || dateController.value.monthTo == null) {
      logger.e("Date isn't chosen");
      value = null;
      return null;
    }

    ///
    /// Calculate invoice
    ///

    /// Electricity higher
    final electricityHigherDifference = electricityHigherNewMonth - electricityHigherLastMonth;

    /// Electricity lower
    final electricityLowerDifference = electricityLowerNewMonth - electricityLowerLastMonth;

    /// Gas
    final gasDifference = gasNewMonth - gasLastMonth;

    /// Water
    final waterDifference = waterNewMonth - waterLastMonth;

    /// Prices
    final prices = hive.getPrices();

    if (prices != null) {
      final sum = double.tryParse(
        ((gasDifference * prices.gasPrice) +
                (electricityHigherDifference * prices.electricityHigherPrice) +
                (electricityLowerDifference * prices.electricityLowerPrice) +
                (waterDifference * prices.waterPrice) +
                feesGas +
                feesElectricity +
                feesWater +
                utility +
                reserve)
            .toStringAsFixed(2),
      );

      /// All is good, generate new [Invoice] & update `state`
      if (sum != null) {
        final newInvoice = Invoice(
          id: invoiceToEdit != null ? invoiceToEdit!.id : uuid.v1(),
          createdDate: DateTime.now(),
          prices: prices,
          fees: Fees(
            feesElectricity: feesElectricity,
            feesGas: feesGas,
            feesWater: feesWater,
            utility: utility,
            reserve: reserve,
          ),
          name: nameController.text.trim(),
          monthFrom: dateController.value.monthFrom!,
          monthTo: dateController.value.monthTo!,
          electricityHigherLastMonth: electricityHigherLastMonth,
          electricityHigherNewMonth: electricityHigherNewMonth,
          electricityLowerLastMonth: electricityLowerLastMonth,
          electricityLowerNewMonth: electricityLowerNewMonth,
          gasLastMonth: gasLastMonth,
          gasNewMonth: gasNewMonth,
          waterLastMonth: waterLastMonth,
          waterNewMonth: waterNewMonth,
          totalPrice: sum,
        );

        logger.d('New invoice generated');

        value = newInvoice;
        return newInvoice;
      }
    }

    value = null;
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../../models/fees.dart';
import '../../../models/invoice.dart';
import '../../../services/firebase_service.dart';
import '../../../services/hive_service.dart';
import '../../../services/logger_service.dart';
import 'invoice_date_controller.dart';

class InvoiceController extends ValueNotifier<Invoice?> implements Disposable {
  final LoggerService logger;
  final HiveService hive;
  final FirebaseService firebase;
  final InvoiceDateController dateController;
  final Invoice? lastInvoice;
  final Invoice? invoiceToEdit;

  InvoiceController({
    required this.logger,
    required this.hive,
    required this.firebase,
    required this.dateController,
    this.lastInvoice,
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

      feesElectricityController.text = invoiceToEdit!.fees.feesElectricity.toStringAsFixed(2);
      feesGasController.text = invoiceToEdit!.fees.feesGas.toStringAsFixed(2);
      feesWaterController.text = invoiceToEdit!.fees.feesWater.toStringAsFixed(2);

      utilityController.text = invoiceToEdit!.fees.utility.toStringAsFixed(2);
      reserveController.text = invoiceToEdit!.fees.reserve.toStringAsFixed(2);
    }

    /// User is creating a new invoice and last invoice exists
    else if (lastInvoice != null) {
      nameController.text = lastInvoice!.name;

      electricityHigherLastMonthController.text = lastInvoice!.electricityHigherNewMonth.toInt().toString();
      electricityLowerLastMonthController.text = lastInvoice!.electricityLowerNewMonth.toInt().toString();

      gasLastMonthController.text = lastInvoice!.gasNewMonth.toInt().toString();

      waterLastMonthController.text = lastInvoice!.waterNewMonth.toInt().toString();
    }

    /// Fill out values in the `fees` section
    if (invoiceToEdit == null) {
      final fees = hive.getFees();

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
    final newInvoiceOrError = generateInvoiceFromTextFields();

    /// Invoice is generated
    if (newInvoiceOrError.invoice != null) {
      final newInvoice = newInvoiceOrError.invoice;

      /// Compare fees
      final oldFees = hive.getFees();
      final newFees = newInvoice!.fees;

      /// If the fees are not the same, add new values in storage
      if (oldFees != newFees) {
        await hive.addNewFees(newFees);
        logger.d('New fees in storage');
      }

      /// Edit passed invoice
      if (invoiceToEdit != null) {
        await firebase.replaceInvoice(
          editedInvoiceId: invoiceToEdit!.id,
          newInvoice: newInvoice,
        );
      }

      /// Create new invoice
      else {
        await firebase.addNewInvoice(newInvoice);
      }

      logger.d('Invoice created');
      return newInvoice;
    }

    return null;
  }

  /// Triggered on every [TextField] change
  /// Calculates invoice and updates `state`
  /// Sets `state` to `null` if some of the values are missing or unable to parse
  ({Invoice? invoice, String? error}) generateInvoiceFromTextFields() {
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
      const error = "Name isn't filled";
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
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
      const error = 'Some of the values is empty';
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
    }

    /// Don't calculate if any of the last month values are higher or same as any of the new month values
    if ((electricityHigherLastMonth >= electricityHigherNewMonth) ||
        (electricityLowerLastMonth >= electricityLowerNewMonth) ||
        (gasLastMonth >= gasNewMonth) ||
        (waterLastMonth >= waterNewMonth)) {
      const error = 'Some of the last month values are higher or same as some of the new month values';
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
    }

    /// Don't calculate if the date isn't picked out
    if (dateController.value.monthFrom == null || dateController.value.monthTo == null) {
      const error = "Date isn't chosen";
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
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

    /// Calculate `sum`
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
          feesElectricity: feesElectricity.toDouble(),
          feesGas: feesGas.toDouble(),
          feesWater: feesWater.toDouble(),
          utility: utility.toDouble(),
          reserve: reserve.toDouble(),
        ),
        name: nameController.text.trim(),
        monthFrom: dateController.value.monthFrom!,
        monthTo: dateController.value.monthTo!,
        electricityHigherLastMonth: electricityHigherLastMonth.toDouble(),
        electricityHigherNewMonth: electricityHigherNewMonth.toDouble(),
        electricityLowerLastMonth: electricityLowerLastMonth.toDouble(),
        electricityLowerNewMonth: electricityLowerNewMonth.toDouble(),
        gasLastMonth: gasLastMonth.toDouble(),
        gasNewMonth: gasNewMonth.toDouble(),
        waterLastMonth: waterLastMonth.toDouble(),
        waterNewMonth: waterNewMonth.toDouble(),
        totalPrice: sum.toDouble(),
      );

      logger.d('New invoice generated');

      value = newInvoice;
      return (invoice: newInvoice, error: null);
    }

    value = null;
    return (invoice: null, error: 'Invoice is null');
  }
}

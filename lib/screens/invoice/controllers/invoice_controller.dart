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
  Future<({Invoice? invoice, String? error})> createInvoice(BuildContext context) async {
    /// Generate new invoice
    final newInvoiceOrError = generateInvoiceFromTextFields();

    /// Error exists, return it
    if (newInvoiceOrError.error != null) {
      return (invoice: null, error: newInvoiceOrError.error);
    }

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
      return (invoice: newInvoice, error: null);
    }

    return (invoice: null, error: 'Ovo se ne bi trebalo dogoditi');
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
      const error = 'Nisi upisao naziv računa.';
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
    }

    /// Don't calculate if the date isn't picked out
    if (dateController.value.monthFrom == null || dateController.value.monthTo == null) {
      const error = 'Nisi odabrao mjesec.';
      logger.e(error);
      value = null;
      return (invoice: null, error: error);
    }

    ///
    /// Don't calculate if any of the values is `null`
    ///
    final missingValueError = generateMissingValue(
      electricityHigherLastMonth: electricityHigherLastMonth,
      electricityHigherNewMonth: electricityHigherNewMonth,
      electricityLowerLastMonth: electricityLowerLastMonth,
      electricityLowerNewMonth: electricityLowerNewMonth,
      gasLastMonth: gasLastMonth,
      gasNewMonth: gasNewMonth,
      waterLastMonth: waterLastMonth,
      waterNewMonth: waterNewMonth,
      feesGas: feesGas,
      feesElectricity: feesElectricity,
      feesWater: feesWater,
      utility: utility,
      reserve: reserve,
    );

    if (missingValueError != null) {
      logger.e(missingValueError);
      value = null;
      return (invoice: null, error: missingValueError);
    }

    /// Don't calculate if any of the last month values are higher or same as any of the new month values
    final lastMonthHigherError = generateLastMonthHigher(
      electricityHigherLastMonth: electricityHigherLastMonth!,
      electricityHigherNewMonth: electricityHigherNewMonth!,
      electricityLowerLastMonth: electricityLowerLastMonth!,
      electricityLowerNewMonth: electricityLowerNewMonth!,
      gasLastMonth: gasLastMonth!,
      gasNewMonth: gasNewMonth!,
      waterLastMonth: waterLastMonth!,
      waterNewMonth: waterNewMonth!,
    );

    if (lastMonthHigherError != null) {
      logger.e(lastMonthHigherError);
      value = null;
      return (invoice: null, error: lastMonthHigherError);
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
              feesGas! +
              feesElectricity! +
              feesWater! +
              utility! +
              reserve!)
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

  /// Goes through all values and returns error if any of the values is `null`
  String? generateMissingValue({
    required double? electricityHigherLastMonth,
    required double? electricityHigherNewMonth,
    required double? electricityLowerLastMonth,
    required double? electricityLowerNewMonth,
    required double? gasLastMonth,
    required double? gasNewMonth,
    required double? waterLastMonth,
    required double? waterNewMonth,
    required double? feesElectricity,
    required double? feesGas,
    required double? feesWater,
    required double? utility,
    required double? reserve,
  }) {
    if (electricityHigherLastMonth == null) {
      return 'Nisi upisao staro stanje više tarife struje.';
    }
    if (electricityHigherNewMonth == null) {
      return 'Nisi upisao novo stanje više tarife struje.';
    }
    if (electricityLowerLastMonth == null) {
      return 'Nisi upisao staro stanje niže tarife struje.';
    }
    if (electricityLowerNewMonth == null) {
      return 'Nisi upisao novo stanje niže tarife struje.';
    }
    if (gasLastMonth == null) {
      return 'Nisi upisao staro stanje plina.';
    }
    if (gasNewMonth == null) {
      return 'Nisi upisao novo stanje plina.';
    }
    if (waterLastMonth == null) {
      return 'Nisi upisao staro stanje vode.';
    }
    if (waterNewMonth == null) {
      return 'Nisi upisao novo stanje vode.';
    }
    if (feesElectricity == null) {
      return 'Nisi upisao naknadu za struju.';
    }
    if (feesGas == null) {
      return 'Nisi upisao naknadu za plin.';
    }
    if (feesWater == null) {
      return 'Nisi upisao naknadu za vodu.';
    }
    if (utility == null) {
      return 'Nisi upisao komunalnu naknadu.';
    }
    if (reserve == null) {
      return 'Nisi upisao pričuvu.';
    }

    return null;
  }

  /// Goes through all values and returns error if any of the last month values are higher than new month values
  String? generateLastMonthHigher({
    required double electricityHigherLastMonth,
    required double electricityHigherNewMonth,
    required double electricityLowerLastMonth,
    required double electricityLowerNewMonth,
    required double gasLastMonth,
    required double gasNewMonth,
    required double waterLastMonth,
    required double waterNewMonth,
  }) {
    if (electricityHigherLastMonth >= electricityHigherNewMonth) {
      return 'Staro stanje više tarife struje je veće od novog stanja.';
    }
    if (electricityLowerLastMonth >= electricityLowerNewMonth) {
      return 'Staro stanje niže tarife struje je veće od novog stanja.';
    }
    if (gasLastMonth >= gasNewMonth) {
      return 'Staro stanje plina je veće od novog stanja.';
    }
    if (waterLastMonth >= waterNewMonth) {
      return 'Staro stanje vode je veće od novog stanja.';
    }

    return null;
  }
}

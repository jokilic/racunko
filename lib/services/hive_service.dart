import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants.dart';
import '../hive_registrar.g.dart';
import '../models/fees.dart';
import '../models/invoice.dart';
import '../models/prices.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService implements Disposable {
  final LoggerService logger;

  HiveService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final Box<Prices> prices;
  late final Box<Fees> fees;
  late final Box<Invoice> invoices;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapters();

    prices = await Hive.openBox<Prices>('pricesBox');
    fees = await Hive.openBox<Fees>('feesBox');
    invoices = await Hive.openBox<Invoice>('invoicesBox');

    if (prices.isEmpty) {
      await addNewPrices(
        Prices(
          electricityHigherPrice: RacunkoConstants.electricityHigherPrice,
          electricityLowerPrice: RacunkoConstants.electricityLowerPrice,
          gasPrice: RacunkoConstants.gasPrice,
          waterPrice: RacunkoConstants.waterPrice,
        ),
      );
    }

    if (fees.isEmpty) {
      await addNewFees(
        Fees(
          feesElectricity: RacunkoConstants.feesElectricity,
          feesGas: RacunkoConstants.feesGas,
          feesWater: RacunkoConstants.feesWater,
          utility: RacunkoConstants.utility,
          reserve: RacunkoConstants.reserve,
        ),
      );
    }
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await prices.close();
    await invoices.close();
    await Hive.close();
  }

  ///
  /// METHODS
  ///

  Prices? getPrices() => prices.values.toList().firstOrNull;

  Fees? getFees() => fees.values.toList().firstOrNull;

  List<Invoice> getInvoices() => invoices.values.toList();

  Invoice? getLastInvoice() => invoices.values.toList().lastOrNull;

  Future<void> addNewPrices(Prices newPrices) async {
    await prices.clear();
    await prices.add(newPrices);
  }

  Future<void> addNewFees(Fees newFees) async {
    await fees.clear();
    await fees.add(newFees);
  }

  Future<void> addNewInvoice(Invoice invoice) async {
    await invoices.add(invoice);
  }
}

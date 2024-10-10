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

  late final Box<String> username;
  late final Box<Invoice> invoices;
  late final Box<Prices> prices;
  late final Box<Fees> fees;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapters();

    username = await Hive.openBox<String>('usernameBox');
    invoices = await Hive.openBox<Invoice>('invoicesBox');
    prices = await Hive.openBox<Prices>('pricesBox');
    fees = await Hive.openBox<Fees>('feesBox');
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await username.close();
    await invoices.close();
    await prices.close();
    await fees.close();
    await Hive.close();
  }

  ///
  /// METHODS
  ///

  List<Invoice> getInvoices() => invoices.values.toList();

  String? getUsername() => username.values.toList().firstOrNull;

  Prices getPrices() =>
      prices.values.toList().firstOrNull ??
      Prices(
        electricityHigherPrice: RacunkoConstants.electricityHigherPrice,
        electricityLowerPrice: RacunkoConstants.electricityLowerPrice,
        gasPrice: RacunkoConstants.gasPrice,
        waterPrice: RacunkoConstants.waterPrice,
      );

  Fees getFees() =>
      fees.values.toList().firstOrNull ??
      Fees(
        feesElectricity: RacunkoConstants.feesElectricity,
        feesGas: RacunkoConstants.feesGas,
        feesWater: RacunkoConstants.feesWater,
        utility: RacunkoConstants.utility,
        reserve: RacunkoConstants.reserve,
      );

  Future<void> addUsername(String? newUsername) async {
    await username.clear();

    if (newUsername != null) {
      await username.add(newUsername);
    }
  }

  Future<void> addInvoices(List<Invoice> newInvoices) async {
    await invoices.clear();
    await invoices.addAll(newInvoices.toList());
  }

  Future<void> addNewPrices(Prices newPrices) async {
    await prices.clear();
    await prices.add(newPrices);
  }

  Future<void> addNewFees(Fees newFees) async {
    await fees.clear();
    await fees.add(newFees);
  }
}

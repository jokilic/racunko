import 'package:hive_ce/hive.dart';
import 'package:racunko/models/fees.dart';
import 'package:racunko/models/invoice.dart';
import 'package:racunko/models/prices.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(FeesAdapter());
    registerAdapter(InvoiceAdapter());
    registerAdapter(PricesAdapter());
  }
}

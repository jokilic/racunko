import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class InvoicesController extends ValueNotifier<List<Invoice>> {
  final LoggerService logger;
  final HiveService hive;

  InvoicesController({
    required this.logger,
    required this.hive,
  }) : super(hive.getInvoices());

  ///
  /// METHODS
  ///

  void updateState() => value = hive.getInvoices();
}

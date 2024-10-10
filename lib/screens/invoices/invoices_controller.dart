import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/invoice.dart';
import '../../services/firebase_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/pdf.dart';

class InvoicesController extends ValueNotifier<({List<Invoice> invoices, String? username})?> implements Disposable {
  final LoggerService logger;
  final FirebaseService firebase;
  final HiveService hive;

  InvoicesController({
    required this.logger,
    required this.firebase,
    required this.hive,
  }) : super((invoices: hive.getInvoices(), username: hive.getUsername()));

  ///
  /// VARIABLES
  ///

  late final StreamSubscription<List<Invoice>?> invoiceStream;

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() => invoiceStream.cancel();

  ///
  /// METHODS
  ///

  /// Listen to [Invoices] `stream` from [Firebase] and store any changes in [Hive]
  void listenInvoicesFromFirebase() => invoiceStream = firebase.getInvoicesStream().listen(
        (newInvoices) async {
          value = (invoices: newInvoices ?? [], username: value?.username);
          await hive.addInvoices(newInvoices ?? []);
        },
      );

  /// Gets username and updates state
  Future<void> getUserNameFromFirebase() async {
    final username = await firebase.getUsername();
    await hive.addUsername(username);

    value = (invoices: value?.invoices ?? [], username: username);
  }

  /// Triggered when the user presses `PDF` icon
  Future<void> pdfPressed(Invoice invoice) async {
    /// Generate it
    final document = await generatePdf(
      invoice: invoice,
    );

    /// Save it
    final pdfFile = await savePdf(
      pdf: document,
      documentName: invoice.id,
    );

    if (pdfFile != null) {
      /// Open it
      await openPdf(
        pdfFile: pdfFile,
      );

      /// Share it
      // await sharePdf(
      //   pdfFile: pdfFile,
      // );
    }
  }
}

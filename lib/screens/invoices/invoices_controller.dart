import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import '../../services/firebase_service.dart';
import '../../services/logger_service.dart';
import '../../util/pdf.dart';

class InvoicesController extends ValueNotifier<String?> {
  final LoggerService logger;
  final FirebaseService firebase;

  InvoicesController({
    required this.logger,
    required this.firebase,
  }) : super(null);

  /// Gets username and updates state
  Future<void> getUserName() async {
    final userName = await firebase.getUserName();
    value = userName;
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

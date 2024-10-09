import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/invoice.dart';
import '../../services/firebase_service.dart';
import '../../services/logger_service.dart';
import '../../util/path.dart';

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

  /// Generates [PDF] from passed [Invoice]
  pw.Document generatePDF(Invoice invoice) => pw.Document()
    ..addPage(
      pw.Page(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.letter,
        build: (context) => pw.Center(
          child: pw.Text('Hello World'),
        ),
      ),
    );

  /// Saves the [PDF] to a temporary location on the device
  Future<void> savePDF({
    required pw.Document pdf,
    required String documentName,
  }) async {
    final tempDirectory = await getPDFTemporaryDirectory();

    if (tempDirectory != null) {
      final file = File('${tempDirectory.path}/$documentName.pdf');
      await file.writeAsBytes(await pdf.save());
    }
  }
}

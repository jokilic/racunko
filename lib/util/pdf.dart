import 'dart:developer';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../models/invoice.dart';
import 'path.dart';

/// Generates [PDF] from passed [Invoice]
Document generatePdf({required Invoice invoice}) => Document()
  ..addPage(
    Page(
      orientation: PageOrientation.landscape,
      pageFormat: PdfPageFormat.letter,
      build: (context) => Center(
        child: Text('Hello World'),
      ),
    ),
  );

/// Saves the [PDF] to a temporary location on the device
Future<File?> savePdf({
  required Document pdf,
  required String documentName,
}) async {
  final tempDirectory = await getPDFTemporaryDirectory();

  if (tempDirectory != null) {
    final pdfFile = File('${tempDirectory.path}/$documentName.pdf');
    final savedPdf = await pdf.save();

    final file = await pdfFile.writeAsBytes(savedPdf);

    log('Saved file -> $file');

    return file;
  }

  return null;
}

/// Opens the [PDF]
Future<void> openPdf({required File pdfFile}) async {
  final result = await OpenFile.open(pdfFile.path);
  log('Open result -> $result');
}

/// Shares the [PDF]
Future<void> sharePdf({required File pdfFile}) async {
  final result = await Share.shareXFiles([XFile(pdfFile.path)]);
  log('Open result -> $result');
}

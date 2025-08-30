import 'dart:io';

import 'package:pdf/widgets.dart';

import '../path.dart';

/// Saves the `PDF` to a temporary location on the device
Future<File?> savePdf({
  required Document pdf,
  required String documentName,
}) async {
  final tempDirectory = await getPDFTemporaryDirectory();

  if (tempDirectory != null) {
    final pdfFile = File('${tempDirectory.path}/$documentName.pdf');
    final savedPdf = await pdf.save();

    final file = await pdfFile.writeAsBytes(savedPdf);

    return file;
  }

  return null;
}

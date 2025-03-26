import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../models/invoice.dart';
import '../screens/pdf/pdf_screen.dart';
import '../theme/icons.dart';
import 'path.dart';

/// Generates [PDF] from passed [Invoice]
Future<Document> generatePdf({required Invoice invoice}) async {
  final backIcon = MemoryImage(
    (await rootBundle.load(RacunkoIcons.back)).buffer.asUint8List(),
  );
  final font400 = await rootBundle.load('assets/fonts/Outfit-Regular.ttf');
  final font600 = await rootBundle.load('assets/fonts/Outfit-SemiBold.ttf');
  final font700 = await rootBundle.load('assets/fonts/Outfit-Bold.ttf');

  return Document()
    ..addPage(
      Page(
        orientation: PageOrientation.portrait,
        pageFormat: PdfPageFormat.a3,
        margin: const EdgeInsets.all(40),
        build: (context) => PdfScreen(
          invoice: invoice,
          backIcon: backIcon,
          font400: Font.ttf(font400),
          font600: Font.ttf(font600),
          font700: Font.ttf(font700),
        ),
      ),
    );
}

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

    return file;
  }

  return null;
}

/// Opens the [PDF]
Future<void> openPdf({required File pdfFile}) async => OpenFile.open(pdfFile.path);

/// Shares the [PDF]
Future<void> sharePdf({required File pdfFile}) async => Share.shareXFiles([XFile(pdfFile.path)]);

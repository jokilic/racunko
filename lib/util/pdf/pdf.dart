import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../models/invoice.dart';
import '../../screens/pdf/pdf_screen.dart';
import '../../theme/icons.dart';

/// Generates [PDF] from passed [Invoice]
Future<Document> generatePdf({required Invoice invoice}) async {
  final backIcon = MemoryImage(
    (await rootBundle.load(RacunkoIcons.back)).buffer.asUint8List(),
  );
  final font400 = await rootBundle.load('assets/fonts/Outfit-Regular.ttf');
  final font600 = await rootBundle.load('assets/fonts/Outfit-SemiBold.ttf');
  final font700 = await rootBundle.load('assets/fonts/Outfit-Bold.ttf');

  return Document()..addPage(
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

/// Opens the [PDF]
Future<void> openPdf({required File pdfFile}) async => OpenFile.open(pdfFile.path);

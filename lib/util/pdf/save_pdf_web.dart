import 'dart:convert';

import 'package:pdf/widgets.dart';
import 'package:web/web.dart' as web;

/// Saves the `PDF` by downloading it
Future<void> savePdf({
  required Document pdf,
  required String documentName,
}) async {
  final bytes = await pdf.save();
  final b64 = base64Encode(bytes);
  final url = 'data:application/pdf;base64,$b64';

  final a = web.HTMLAnchorElement()
    ..href = url
    ..download = '$documentName.pdf'
    ..style.display = 'none';

  web.document.body?.append(a);
  a
    ..click()
    ..remove();
}

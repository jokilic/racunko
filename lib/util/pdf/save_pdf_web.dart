import 'dart:io';
import 'dart:js_interop';

import 'package:pdf/widgets.dart';
import 'package:web/web.dart' as web;

/// Saves the `PDF` by downloading it
Future<File?> savePdf({
  required Document pdf,
  required String documentName,
}) async {
  final bytes = await pdf.save();

  final jsU8 = bytes.toJS;
  final parts = <web.BlobPart>[jsU8].toJS;
  final blob = web.Blob(parts, web.BlobPropertyBag(type: 'application/pdf'));
  final url = web.URL.createObjectURL(blob);

  final a = web.HTMLAnchorElement()
    ..href = url
    ..download = '$documentName.pdf'
    ..style.display = 'none';

  web.document.body?.append(a);
  a
    ..click()
    ..remove();
  web.URL.revokeObjectURL(url);

  return null;
}

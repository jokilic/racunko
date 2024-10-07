import 'package:flutter/material.dart';

import '../../models/invoice.dart';

class InvoiceScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceScreen({
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Text(
            invoice.name,
          ),
        ),
      );
}

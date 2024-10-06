import 'package:flutter/material.dart';

import '../../models/invoice.dart';

class InvoiceCreatedScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCreatedScreen({
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

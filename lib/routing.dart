import 'package:flutter/material.dart';

import 'models/invoice.dart';
import 'screens/create_invoice/create_invoice_screen.dart';
import 'screens/invoice_created/invoice_created_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'util/navigation.dart';

/// Opens [InvoicesScreen]
void openInvoices(BuildContext context) => pushScreen(
      InvoicesScreen(),
      context: context,
    );

/// Opens [CreateInvoiceScreen]
void openCreateInvoice(
  BuildContext context, {
  required Invoice? previousInvoice,
}) =>
    pushScreen(
      CreateInvoiceScreen(
        previousInvoice: previousInvoice,
      ),
      context: context,
    );

/// Opens [InvoiceCreatedScreen]
void openInvoiceCreated(
  BuildContext context, {
  required Invoice invoice,
}) =>
    pushScreen(
      InvoiceCreatedScreen(
        invoice: invoice,
      ),
      context: context,
    );

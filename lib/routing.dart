import 'package:flutter/material.dart';

import 'models/invoice.dart';
import 'screens/create_invoice/create_invoice_screen.dart';
import 'screens/invoice/invoice_screen.dart';
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
  required Invoice? invoiceToEdit,
}) =>
    pushScreen(
      CreateInvoiceScreen(
        invoiceToEdit: invoiceToEdit,
      ),
      context: context,
    );

/// Opens [InvoiceScreen]
void openInvoice(
  BuildContext context, {
  required Invoice invoice,
}) =>
    pushScreen(
      InvoiceScreen(
        invoice: invoice,
      ),
      context: context,
    );
